import Foundation

enum TodoStates: String {
    case active = "active"
    case done = "done"
}

struct Todo {
    let creationDate: Date // yyyy-MM-dd
    var title: String
    var description: String
    var state: TodoStates = .active
}

struct TodoDTO: Codable {
    let creationDate: String
    let title: String
    let description: String
    let state: String
    
    func toDomain() -> Todo {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: creationDate) ?? Date()
        let state = TodoStates.init(rawValue: state) ?? .active
        return Todo(creationDate: date, title: title, description: description, state: state)
    }
}
