import Foundation

class DetailPresenter: DetailScreenPresenter {
    weak var view: DetailScreenView?
    var router: DetailScreenRouter?
    
    var todo: Todo?
    
    func viewDidLoad() {
        view?.showDetails(todo?.title ?? "", todo?.description ?? "", todo?.creationDate ?? Date(), isNew: todo == nil)
    }
    
    func saveNewTodo(with title: String, and description: String) {
        router?.saveTodo(Todo(creationDate: Date(), title: title, description: description, state: .active))
    }
}
