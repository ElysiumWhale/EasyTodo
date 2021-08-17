import UIKit

protocol StoryboardedView: AnyObject {
    static func instantiate(from storyboard: Storyboards) -> Self
}

extension StoryboardedView {
    static func instantiate(from storyboard: Storyboards) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: .main)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}

protocol DetailScreenView: StoryboardedView {
    var presenter: DetailScreenPresenter? { get set }
    
    func showDetails(for todo: Todo)
}


protocol DetailScreenPresenter {
    var view: DetailScreenView? { get set }
    var router: DetailScreenRouter? { get set }
    var todo: Todo? { get set }
    
    func viewDidLoad()
}

protocol DetailScreenRouter {
    func dismiss()
    func addNewTodo(_ todo: Todo)
    func saveTodo(_ todo: Todo)
    
    static func createModule(for todo: Todo) -> UIViewController
}
