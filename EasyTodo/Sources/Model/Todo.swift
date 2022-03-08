import Foundation

enum TodoStates: String {
    case active = "active"
    case done = "done"
}

class Todo {
    let id: Int
    /// yyyy-MM-dd
    let creationDate: Date
    var title: String
    var description: String
    var state: TodoStates = .active

    init(id: Int, creationDate: Date, title: String, description: String, state: TodoStates) {
        self.id = id
        self.creationDate = creationDate
        self.title = title
        self.description = description
        self.state = state
    }
}

struct TodoDTO: Codable {
    let id: Int
    let creationDate: String
    let title: String
    let description: String
    let state: String

    func toDomain() -> Todo {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = .serverDateMask
        let date = dateFormatter.date(from: creationDate) ?? Date()
        let state = TodoStates.init(rawValue: state) ?? .active
        return Todo(id: id, creationDate: date, title: title, description: description, state: state)
    }
}
