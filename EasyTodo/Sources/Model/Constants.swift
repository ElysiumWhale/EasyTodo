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

enum URLStrings: String {
    case jsonServerTodos = "https://my-json-server.typicode.com/ElysiumWhale/EasyTodo/todos"
}
