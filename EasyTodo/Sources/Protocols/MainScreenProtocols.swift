import UIKit

protocol NewTodoReciever {
    func todoDidAdded(_ todo: Todo)
}

protocol MainScreenRouter {
    var view: MainScreenView? { get set }
    
    func showDetail(from view: MainScreenView, _ todo: Todo)
    func showNewDetail(from view: MainScreenView)
}

protocol MainScreenPresenter {
    var view: MainScreenView? { get set }
    var interactor: MainScreenInteractor? { get set }
    var router: MainScreenRouter? { get set }
    
    func interactorDidLoadTodos(_ result: Result<[Todo], Error>)
    func todoDidAdd(_ todo: Todo)
    func showDetailOf(_ todo: Todo)
    func showNewDetail()
}

protocol MainScreenInteractor {
    var presenter: MainScreenPresenter? { get set }
    
    func getTodos()
}

protocol MainScreenView: AnyObject {
    func update(with todos: [Todo])
    func update(with newTodo: Todo)
    func update(with error: String)
}
