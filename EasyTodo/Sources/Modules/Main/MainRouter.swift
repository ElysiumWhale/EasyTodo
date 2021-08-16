import UIKit

class MainRouter: AnyRouter {
    typealias View = MainView
    
    var view: View?
    
    var navigationController: UINavigationController?
    
    static func start() -> MainRouter {
        let view = MainView.instantiate(from: .main)
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.navigationController = UINavigationController()
        
        router.navigationController?.setViewControllers([view], animated: false)
        router.view = view
        return router
    }
}

//class NavigationController: UINavigationController, AnyView {
//    var presenter: AnyPresenter?
//
//
//}
