import Foundation

class MainInteractor: MainScreenInteractor {
    let networkService: TodosService

    var presenter: MainScreenPresenter?

    init(networkService: TodosService = NetworkService()) {
        self.networkService = networkService
    }

    func getTodos() async {
        let result = await networkService.loadTodos()
        switch result {
            case .success(let todos):
                presenter?.interactorDidLoadTodos(todos)
            case .failure(let error):
                presenter?.interactorDidFailedWithError(error)
        }
    }
}
