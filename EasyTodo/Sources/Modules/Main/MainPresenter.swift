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

    func interactorDidLoadTodos(_ todos: [Todo]) {
        self.todos = todos
        view?.update()
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
        view?.update()
    }

    func todoDidUpdate(_ todo: Todo) {
        guard let existedTodo = todos.first(where: { $0.id == todo.id }) else {
            return
        }

        existedTodo.title = todo.title
        existedTodo.description = todo.description
        view?.update()
    }
}
