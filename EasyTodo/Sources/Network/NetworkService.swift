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

final class MockService: TodosService, NetworkRequestable {
    func loadTodos() async -> Result<[Todo], AppErrors> {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return .success(.mocks)
    }
}
