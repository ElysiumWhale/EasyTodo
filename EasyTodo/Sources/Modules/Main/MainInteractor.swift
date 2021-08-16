import Foundation

protocol MainScreenInteractor: AnyInteractor {
    func getTodos()
}

class MainInteractor: MainScreenInteractor {
    typealias Presenter = MainPresenter
    
    var presenter: Presenter?
    
    func getTodos() {
        guard let url = URL(string: URLStrings.jsonServerTodos.rawValue) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidLoadTodos(.failure(AppErrors.connectionError))
                return
            }

            do {
                let todos = try JSONDecoder().decode([TodoDTO].self, from: data)
                self?.presenter?.interactorDidLoadTodos(.success(todos.map { $0.toDomain()} ))
            }
            catch {
                self?.presenter?.interactorDidLoadTodos(.failure(AppErrors.corruptedData))
            }
        }

        task.resume()
        
        // test
        // presenter?.interactorDidLoadTodos(.success(Mocks.todos))
    }
}
