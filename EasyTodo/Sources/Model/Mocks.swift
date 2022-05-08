import Foundation

extension Array where Element == Todo {
    static var mocks = [
        Todo(id: 10,
             creationDate: Date(),
             title: "Write module",
             description: "djofjh ifhsifjns fkjsnf skjfnskjnf skfjns fjnfksjfn skfjns efjsn efj jsnf shsfghfghsfgh sfhsfgh sfthsfg",
             state: .done),
        Todo(id: 20,
             creationDate: Date(),
             title: "Test module",
             description: .empty,
             state: .done),
        Todo(id: 30,
             creationDate: Date(),
             title: "Release module",
             description: "Hello world! Wanna go for a walk",
             state: .active)
    ]
}
