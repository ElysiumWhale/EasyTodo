import UIKit

enum MainViewSections: String {
    case active = "Active"
    case done = "Done"

    static prefix func !(value: Self) -> Self {
        switch value {
            case .active:
                return .done
            case .done:
                return .active
        }
    }
}

final class MainView: InitialazableViewController, MainScreenView {
    private let addItem = UIBarButtonItem()
    private lazy var collectionDirector: MainViewCollectionDirector = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: .mainViewCompositionalLayout)
        let director = MainViewCollectionDirector(collection: view)
        director.input = self
        return director
    }()

    var presenter: MainScreenPresenter?

    private var dataSource: DataSource<MainViewSections, Todo.ID> {
        collectionDirector.dataSource
    }

    private var collection: UICollectionView {
        collectionDirector.collectionView
    }

    // MARK: - InitialazableView
    override func addViews() {
        navigationItem.rightBarButtonItem = addItem
        view.addSubviews(collection)
    }

    override func configureLayout() {
        collection.alwaysBounceVertical = true
        collection.edgesToSuperview()
    }

    override func configureAppearance() {
        navigationController?.navigationBar.prefersLargeTitles = true
        addItem.image = UIImage(systemName: "plus")
        addItem.tintColor = .appTint(.main)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .systemBackground
    }

    override func localize() {
        collection.backgroundView = createBackground(labelText: "Loading...")
        navigationItem.title = "Easy Todo"
    }

    override func configureActions() {
        addItem.target = self
        addItem.action = #selector(addTodoDidPress)
    }

    // MARK: - MainScreenView
    func didLoad(todos: [Todo]) {
        dispatch {
            self.didLoadTodos()
        }
    }

    func todoDidAdd(_ todo: Todo) {
        dispatch { [self] in
            var snapshot = dataSource.snapshot()
            snapshot.addItemsWithSectionCheck([todo.id], to: .active)
            dataSource.apply(snapshot)
        }
    }

    func todoDidUpdate(_ todo: Todo) {
        dispatch { [self] in
            var snapshot = dataSource.snapshot()
            snapshot.reloadItems([todo.id])
            dataSource.apply(snapshot)
        }
    }

    func update(with error: String) {
        dispatch { [self] in
            var snapshot = dataSource.snapshot()
            snapshot.deleteAllItems()
            snapshot.deleteSections([.done, .active])
            dataSource.apply(snapshot)
            collection.backgroundView = createBackground(labelText: error)
        }
    }

    // MARK: - Private methods
    @objc private func addTodoDidPress(_ sender: Any) {
        presenter?.showNewDetail()
    }

    private func didLoadTodos() {
        var snapshot = NSDiffableDataSourceSnapshot<MainViewSections, Todo.ID>()

        let activeIds = presenter?.todos.filter { $0.state == .active }.map { $0.id } ?? []
        snapshot.addItemsWithSectionCheck(activeIds, to: .active)

        let doneIds = presenter?.todos.filter { $0.state == .done }.map { $0.id } ?? []
        snapshot.addItemsWithSectionCheck(doneIds, to: .done)

        dataSource.apply(snapshot)

        collection.backgroundView = activeIds.isEmpty && doneIds.isEmpty
            ? createBackground(labelText: "No todos. Press \"+\" to add new.")
            : nil
    }

    private func toggleTodo(todo: Todo?) {
        guard let todo = todo else {
            return
        }

        var snapshot = dataSource.snapshot()
        snapshot.deleteItem(todo.id)
        snapshot.addItemsWithSectionCheck([todo.id],
                                          to: todo.state == .done ? .done : .active)
        dataSource.apply(snapshot)
    }
}

// MARK: - MainViewCollectionInput
extension MainView: MainViewCollectionInput {
    func configureCell(_ cell: TodosCell, with todo: Todo) {
        cell.configure(model: todo) { [weak self, weak todo] in
            self?.toggleTodo(todo: todo)
        }
    }

    func model(for id: Todo.ID) -> Todo? {
        presenter?.todos.first(where: { $0.id == id })
    }

    func configureHeader(view: SectionHeaderView, section: Int) {
        switch section {
            case 0:
                view.text = MainViewSections.active.rawValue
            case 1:
                view.text = MainViewSections.done.rawValue
            default:
                return
        }
    }

    func onSelectItem(at indexPath: IndexPath) {
        guard let presenter = presenter,
              let cell = collection.cellForItem(at: indexPath) as? TodosCell,
              let model = cell.model else {
            return
        }

        presenter.showDetail(of: model)
    }
}

// MARK: - Snapshot helper
private extension NSDiffableDataSourceSnapshot where SectionIdentifierType == MainViewSections {
    mutating func addItemsWithSectionCheck(_ items: [ItemIdentifierType], to section: SectionIdentifierType) {
        guard !items.isEmpty else {
            return
        }

        if indexOfSection(section) == nil || numberOfItems(inSection: section) < 1 {
            if indexOfSection(!section) == nil {
                appendSections([section])
            } else {
                section == .active
                    ? insertSections([section], beforeSection: .done)
                    : insertSections([section], afterSection: .active)
            }
        }

        appendItems(items, toSection: section)
    }
}
