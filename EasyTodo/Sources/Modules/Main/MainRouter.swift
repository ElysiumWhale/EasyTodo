import UIKit

class MainRouter: MainScreenRouter {
    var view: MainScreenView?
    
    class func start() -> UIViewController {
        let navigationController = UIStoryboard(name: Storyboards.main.rawValue, bundle: .main).instantiateViewController(identifier: "MainNavigationController")
        
        guard let view = navigationController.children.first as? MainView else { return UINavigationController() }
        
        var presenter: MainScreenPresenter = MainPresenter()
        var interactor: MainScreenInteractor = MainInteractor()
        var router: MainScreenRouter = MainRouter()
        
        router.view = view
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        return navigationController
    }
    
    func showDetail(from view: MainScreenView, _ todo: Todo) {
        let postDetailVC = DetailRouter.createModule(for: todo)
        
        if let view = view as? UIViewController {
            view.navigationController?.present(postDetailVC, animated: true)
        }
    }
    
    func showNewDetail(from view: MainScreenView) {
        let postDetailVC = DetailRouter.createAddingModuleFor(delegate: self)
        
        if let view = view as? UIViewController {
            view.navigationController?.present(postDetailVC, animated: true)
        }
    }
}

extension MainRouter: NewTodoReciever {
    func todoDidAdded(_ todo: Todo) {
        view?.update(with: todo)
    }
}
