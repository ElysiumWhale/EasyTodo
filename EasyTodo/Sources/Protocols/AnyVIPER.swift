import UIKit

protocol AnyView {
    associatedtype Presenter = AnyPresenter
    
    var presenter: Presenter? { get set }
}

protocol AnyInteractor {
    associatedtype Presenter = AnyPresenter
    
    var presenter: Presenter? { get set }
}

protocol AnyPresenter {
    associatedtype View = AnyView
    associatedtype Router = AnyRouter
    associatedtype Interactor = AnyInteractor
    
    var view: View? { get set }
    var interactor: Interactor? { get set }
    var router: Router? { get set }
}

protocol AnyEntity {
    
}

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    associatedtype View = AnyView & UIViewController
    associatedtype Router = AnyRouter
    
    var view: View? { get set }
    
    static func start() -> Router
}

protocol StoryboardedView: AnyView {
    static func instantiate(from storyboard: Storyboards) -> Self
}

extension StoryboardedView {
    static func instantiate(from storyboard: Storyboards) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: .main)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}
