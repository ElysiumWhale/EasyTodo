import Foundation

class DetailPresenter: DetailScreenPresenter {
    weak var view: DetailScreenView?
    var router: DetailScreenRouter?

    var todo: Todo?

    func viewDidLoad() {
        view?.showDetails(todo?.title ?? .empty,
                          todo?.description ?? .empty,
                          todo?.creationDate ?? Date(),
                          isNew: todo == nil)
    }

    func saveTodo(title: String, description: String) {
        todo?.title = title
        todo?.description = description

        router?.onSaveTodo?(todo ?? Todo(id: Int.random(in: 10...10000),
                                         creationDate: Date(),
                                         title: title,
                                         description: description,
                                         state: .active))
    }
}
