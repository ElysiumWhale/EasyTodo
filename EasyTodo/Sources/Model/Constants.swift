import Foundation

enum Storyboards: String {
    case launch = "LaunchScreen"
    case main = "Main"
}

enum Cells: String {
    case todoCell = "TodoCell"
}

enum AppErrors: String, Error {
    case connectionError = "Connection error"
    case badResponse = "Bad response"
    case corruptedData = "Corrupted data"
}

enum UrlFactory {
    static var todosUrl: URL {
        URL(string: "https://my-json-server.typicode.com/ElysiumWhale/EasyTodo/todos")!
    }
}
