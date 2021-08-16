import UIKit

protocol MainScreenPresenter: AnyPresenter {
    func interactorDidLoadTodos(_ result: Result<[Todo], Error>)
}

class MainPresenter: MainScreenPresenter {
    typealias View = MainView
    typealias Interactor = MainInteractor
    typealias Router = MainRouter
    
    var view: View?
    
    var interactor: Interactor? {
        didSet {
            interactor?.getTodos()
        }
    }
    
    var router: Router?
    
    func interactorDidLoadTodos(_ result: Result<[Todo], Error>) {
        switch result {
            case .success(let todos):
                view?.update(with: todos)
            case .failure(let error):
                view?.update(with: error.localizedDescription)
        }
    }
}
