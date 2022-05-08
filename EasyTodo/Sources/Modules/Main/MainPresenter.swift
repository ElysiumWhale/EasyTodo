import UIKit

class MainPresenter: MainScreenPresenter {
    var view: MainScreenView?
    var router: MainScreenRouter?

    var interactor: MainScreenInteractor? {
        didSet {
            Task {
                await interactor?.getTodos()
            }
        }
    }

    private(set) var todos: [Todo] = []

    private var active: [Todo] {
        todos.filter { $0.state == .active }
    }

    private var done: [Todo] {
        todos.filter { $0.state == .done }
    }

    func model(for indexPath: IndexPath) -> Todo? {
        switch indexPath.section {
            case 0:
                return active.isEmpty ? done[indexPath.row] : active[indexPath.row]
            case 1:
                return done.isEmpty ? active[indexPath.row] : done[indexPath.row]
            default:
                return nil
        }
    }

    func interactorDidLoadTodos(_ todos: [Todo]) {
        self.todos = todos
        view?.didLoad(todos: todos)
    }

    func interactorDidFailedWithError(_ error: AppErrors) {
        todos = []
        view?.update(with: error.localizedDescription)
    }

    func showDetail(of todo: Todo) {
        router?.showDetail(for: todo)
    }

    func showNewDetail() {
        router?.showNewDetail()
    }

    func todoDidAdd(_ todo: Todo) {
        todos.append(todo)
        view?.todoDidAdd(todo)
    }

    func todoDidUpdate(_ todo: Todo) {
        guard let existedTodo = todos.first(where: { $0.id == todo.id }) else {
            return
        }

        existedTodo.title = todo.title
        existedTodo.description = todo.description
        view?.todoDidUpdate(existedTodo)
    }
}
