import UIKit

protocol MainScreenRouter {
    func showDetail(from view: MainScreenView, _ todo: Todo)
    func detailDidFinished(with: Todo?, isNew: Bool)
}

protocol MainScreenPresenter {
    var view: MainScreenView? { get set }
    var interactor: MainScreenInteractor? { get
        set }
    var router: MainScreenRouter? { get set }
    
    func interactorDidLoadTodos(_ result: Result<[Todo], Error>)
    func showDetailOf(_ todo: Todo)
}

protocol MainScreenInteractor {
    var presenter: MainScreenPresenter? { get set }
    
    func getTodos()
}

protocol MainScreenView: AnyObject {
    func update(with todos: [Todo])
    func update(with error: String)
}
