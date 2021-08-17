import UIKit

class MainView: UIViewController, MainScreenView {
    @IBOutlet private var todosCollectionView: UICollectionView!
    
    var presenter: MainScreenPresenter?
    
    private var todos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todosCollectionView.delegate = self
        todosCollectionView.dataSource = self
        todosCollectionView.alpha = 0
        todosCollectionView.alwaysBounceVertical = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = "Easy Todo"
    }
    
    func update(with todos: [Todo]) {
        DispatchQueue.main.async { [weak self] in
            self?.todosCollectionView.backgroundView = nil
            self?.todos = todos
            self?.todosCollectionView.reloadData()
            self?.todosCollectionView.fadeIn(0.6)
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.todos = []
            self?.todosCollectionView.reloadData()
            self?.todosCollectionView.backgroundView = self?.createBackground(labelText: error)
            self?.todosCollectionView.fadeIn(0.6)
        }
    }
    
    @IBAction func addTodoDidPress(_ sender: Any) {
        //
    }
}

// MARK: - UICollectionViewDelegate
extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showDetailOf(todos[indexPath.row])
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
