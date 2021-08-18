import UIKit

class DetailRouter: DetailScreenRouter {
    var todoRecieverDelegate: NewTodoReciever?
    
    class func createModule(for todo: Todo) -> UIViewController {
        let view: DetailScreenView = DetailView.instantiate(from: .main)
        configureModule(for: view, todo: todo)
        return view as! UIViewController
    }
    
    class func createAddingModuleFor(delegate: NewTodoReciever) -> UIViewController {
        let view: DetailScreenView = DetailView.instantiate(from: .main)
        configureModule(for: view, delegate: delegate)
        return view as! UIViewController
    }
    
    private class func configureModule(for view: DetailScreenView, todo: Todo? = nil, delegate: NewTodoReciever? = nil) {
        var presenter: DetailScreenPresenter = DetailPresenter()
        let router = DetailRouter()
        router.todoRecieverDelegate = delegate
        view.presenter = presenter
        presenter.todo = todo
        presenter.view = view
        presenter.router = router
    }
    
    func saveTodo(_ todo: Todo) {
        todoRecieverDelegate?.todoDidAdded(todo)
    }
}
