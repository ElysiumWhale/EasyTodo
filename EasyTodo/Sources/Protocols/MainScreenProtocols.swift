import UIKit

protocol MainScreenRouter: Routable {
    var presenter: MainScreenPresenter? { get set }

    func start() -> UIViewController
    func showDetail(for todo: Todo)
    func showNewDetail()
}

protocol MainScreenPresenter: AnyObject {
    var view: MainScreenView? { get set }
    var interactor: MainScreenInteractor? { get set }
    var router: MainScreenRouter? { get set }

    var todos: [Todo] { get }

    func interactorDidLoadTodos(_ result: Result<[Todo], Error>)
    func todoDidAdd(_ todo: Todo)
    func todoDidUpdate(_ todo: Todo)
    func showDetailOf(_ todo: Todo)
    func showNewDetail()
}

protocol MainScreenInteractor {
    var presenter: MainScreenPresenter? { get set }

    func getTodos()
}

protocol MainScreenView: AnyObject {
    func update()
    func update(with error: String)
}
