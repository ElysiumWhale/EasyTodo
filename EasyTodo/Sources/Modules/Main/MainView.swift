import UIKit

class MainView: UIViewController, MainScreenView {
    @IBOutlet private var todosCollectionView: UICollectionView!
    
    var presenter: MainScreenPresenter?
    
    private var todos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todosCollectionView.delegate = self
        todosCollectionView.dataSource = self
        todosCollectionView.alwaysBounceVertical = true
        todosCollectionView.backgroundView = createBackground(labelText: "Loading...")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = "Easy Todo"
    }
    
    func update(with todos: [Todo]) {
        DispatchQueue.main.async { [weak self] in
            self?.todosCollectionView.backgroundView = nil
            self?.todos = todos
            self?.todosCollectionView.reloadData()
            if todos.isEmpty {
                self?.todosCollectionView.backgroundView = self?.createBackground(labelText: "No todos. Press \"+\" to add new.")
            }
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.todos = []
            self?.todosCollectionView.reloadData()
            self?.todosCollectionView.backgroundView = self?.createBackground(labelText: error)
        }
    }
    
    func update(with newTodo: Todo) {
        DispatchQueue.main.async { [weak self] in
            let needToFadeIn = self?.todos.isEmpty ?? false
            self?.todos.append(newTodo)
            self?.todosCollectionView.reloadData()
            if needToFadeIn {
                self?.todosCollectionView.backgroundView = nil
            }
        }
    }
    
    @IBAction func addTodoDidPress(_ sender: Any) {
        presenter?.showNewDetail()
    }
}

// MARK: - UICollectionViewDelegate
extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showDetailOf(todos[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5,
                       delay: 0.05 * Double(indexPath.row),
                       animations: { cell.alpha = 1 })
    }
}

// MARK: - UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        todos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.todoCell.rawValue, for: indexPath) as? TodoCell {
            let todo = todos[indexPath.row]
            cell.configure(title: todo.title, description: todo.description,
                           state: todo.state, delegate: self, index: indexPath.row)
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - TodoCellDelegate
extension MainView: TodoCellDelegate {
    func todoCellDelegate(didToggle state: TodoStates, at index: Int) {
        todos[index].state = state
    }
}
