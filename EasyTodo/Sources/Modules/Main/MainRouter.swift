import UIKit

class MainRouter: MainScreenRouter {
    class func start() -> UIViewController {
        let navigationController = UIStoryboard(name: Storyboards.main.rawValue, bundle: .main).instantiateViewController(identifier: "MainNavigationController")
        
        guard let view = navigationController.children.first as? MainView else { return UINavigationController() }
        
        var presenter: MainScreenPresenter = MainPresenter()
        var interactor: MainScreenInteractor = MainInteractor()
        let router: MainScreenRouter = MainRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return navigationController
    }
    
    func showDetail(from view: MainScreenView, _ todo: Todo) {
        let postDetailVC = DetailRouter.createModule(for: todo)
        
        if let view = view as? UIViewController {
            view.navigationController?.present(postDetailVC, animated: true)
        }
    }
    
    func detailDidFinished(with: Todo? = nil, isNew: Bool = false) {
        
    }
}
