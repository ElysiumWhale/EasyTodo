import UIKit

protocol StoryboardedView {
    static func instantiate(from storyboard: Storyboards) -> Self
}

extension StoryboardedView {
    static func instantiate(from storyboard: Storyboards) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: .main)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}

protocol DetailScreenView: StoryboardedView, UIViewController {
    var presenter: DetailScreenPresenter? { get set }
}

protocol DetailScreenPresenter {
    var view: DetailScreenView? { get set }
    var router: DetailScreenRouter? { get set }
    var todo: Todo? { get set }

    func saveTodo(title: String, description: String)
}

protocol DetailScreenRouter: Routable {
    var onSaveTodo: ParameterClosure<Todo>? { get set }
}
