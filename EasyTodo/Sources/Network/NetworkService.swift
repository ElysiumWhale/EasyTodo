import Foundation

protocol TodosService {
    func loadTodos() async -> Result<[Todo], AppErrors>
}

final class NetworkService: TodosService, NetworkRequestable {
    func loadTodos() async -> Result<[Todo], AppErrors> {
        let result: Result<[TodoDTO], AppErrors> = await makeRequest(UrlFactory.todosUrl)
        return result.map { $0.map { $0.toDomain() } }
    }
}
