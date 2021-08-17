import Foundation

class DetailPresenter: DetailScreenPresenter {
    weak var view: DetailScreenView?
    var router: DetailScreenRouter?
    
    var todo: Todo?
    
    func viewDidLoad() {
        view?.showDetails(for: todo!)
    }
}
