import UIKit

final class MainView: UIViewController, MainScreenView {
    @IBOutlet private var todosCollectionView: UICollectionView!

    var presenter: MainScreenPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        todosCollectionView.delegate = self
        todosCollectionView.dataSource = self
        todosCollectionView.alwaysBounceVertical = true
        todosCollectionView.backgroundView = createBackground(labelText: "Loading...")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = "Easy Todo"
    }

    func update(with error: String) {
        dispatch { [weak self] in
            self?.todosCollectionView.reloadData()
            self?.todosCollectionView.backgroundView = self?.createBackground(labelText: error)
        }
    }

    func update() {
        dispatch { [weak self] in
            self?.updateCollection()
        }
    }

    @IBAction func addTodoDidPress(_ sender: Any) {
        presenter?.showNewDetail()
    }

    private func updateCollection() {
        todosCollectionView.reloadData()
        todosCollectionView.backgroundView = todosCollectionView.isEmpty()
            ? createBackground(labelText: "No todos. Press \"+\" to add new.")
            : nil
    }
}

// MARK: - UICollectionViewDelegate
extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter = presenter else {
            return
        }

        presenter.showDetailOf(presenter.todos[indexPath.row])
    }
}

// MARK: - UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        presenter?.todos.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.todoCell.rawValue,
                                                            for: indexPath) as? TodoCell,
              let todo = presenter?.todos[indexPath.row] else {
                  return UICollectionViewCell()
              }

        cell.configure(title: todo.title, description: todo.description,
                       state: todo.state, index: indexPath.row)
        cell.onToggle = { [weak self] params in
            self?.presenter?.todos[params.index].state = params.state
        }

        return cell
    }
}
