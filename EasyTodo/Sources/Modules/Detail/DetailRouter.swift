import UIKit

enum DetailScenario {
    case new
    case edit(element: Todo)
}

class DetailRouter: BaseRouter, DetailScreenRouter {
    var onSaveTodo: ParameterClosure<Todo>?

    func start(with scenario: DetailScenario) {
        let module = createDetailModule(for: scenario, onSave: onSaveTodo)
        navigationController?.present(module, animated: true)
    }

    func createDetailModule(for scenario: DetailScenario,
                            onSave: ParameterClosure<Todo>?) -> DetailScreenView {
        let view: DetailScreenView = DetailView.instantiate(from: .main)
        switch scenario {
            case .new:
                configureModule(for: view)
            case .edit(let element):
                configureModule(for: view, todo: element)
        }
        return view
    }

    private func configureModule(for view: DetailScreenView,
                                 todo: Todo? = nil,
                                 onSave: ParameterClosure<Todo>? = nil) {
        var presenter: DetailScreenPresenter = DetailPresenter()
        presenter.router = self
        presenter.todo = todo
        presenter.view = view
        view.presenter = presenter
    }
}
