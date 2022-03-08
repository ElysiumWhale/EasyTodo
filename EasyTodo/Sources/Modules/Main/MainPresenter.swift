import UIKit

class MainPresenter: MainScreenPresenter {
    var view: MainScreenView?
    var router: MainScreenRouter?

    var interactor: MainScreenInteractor? {
        didSet {
            interactor?.getTodos()
        }
    }

    private(set) var todos: [Todo] = []

    func interactorDidLoadTodos(_ result: Result<[Todo], Error>) {
        switch result {
            case .success(let list):
                todos = list
                view?.update()
            case .failure(let error):
                todos = []
                view?.update(with: error.localizedDescription)
        }
    }

    func showDetailOf(_ todo: Todo) {
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
