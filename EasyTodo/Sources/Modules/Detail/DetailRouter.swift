import UIKit

class DetailRouter: DetailScreenRouter {
    class func createModule(for todo: Todo) -> UIViewController {
        let view: DetailScreenView = DetailView.instantiate(from: .main)
        var presenter: DetailScreenPresenter = DetailPresenter()
        let router = DetailRouter()
        
        view.presenter = presenter
        presenter.todo = todo
        presenter.view = view
        presenter.router = router
        
        return view as! UIViewController
    }
    
    func dismiss() {
        
    }
    
    func addNewTodo(_ todo: Todo) {
        
    }
    
    func saveTodo(_ todo: Todo) {
        
    }
}
