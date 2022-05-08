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

    func model(for indexPath: IndexPath) -> Todo?
    func interactorDidLoadTodos(_ todos: [Todo])
    func interactorDidFailedWithError(_ error: AppErrors)
    func todoDidAdd(_ todo: Todo)
    func todoDidUpdate(_ todo: Todo)
    func showDetail(of todo: Todo)
    func showNewDetail()
}

protocol MainScreenInteractor {
    var presenter: MainScreenPresenter? { get set }

    func getTodos() async
}

protocol MainScreenView: AnyObject {
    func todoDidAdd(_ todo: Todo)
    func todoDidUpdate(_ todo: Todo)
    func didLoad(todos: [Todo])
    func update(with error: String)
}
