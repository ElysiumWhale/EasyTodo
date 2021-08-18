import UIKit

class MainPresenter: MainScreenPresenter {
    var view: MainScreenView?
    
    var interactor: MainScreenInteractor? {
        didSet {
            interactor?.getTodos()
        }
    }
    
    var router: MainScreenRouter?
    
    func interactorDidLoadTodos(_ result: Result<[Todo], Error>) {
        switch result {
            case .success(let todos):
                view?.update(with: todos)
            case .failure(let error):
                view?.update(with: error.localizedDescription)
        }
    }
    
    func showDetailOf(_ todo: Todo) {
        router?.showDetail(from: view!, todo)
    }
    
    func showNewDetail() {
        router?.showNewDetail(from: view!)
    }
    
    func todoDidAdd(_ todo: Todo) {
        view?.update(with: todo)
    }
}
