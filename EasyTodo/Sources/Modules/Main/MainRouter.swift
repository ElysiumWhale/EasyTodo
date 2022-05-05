import UIKit

class MainRouter: BaseRouter, MainScreenRouter {
    weak var presenter: MainScreenPresenter?

    func showDetail(for todo: Todo) {
        let detailRouter = DetailRouter()
        detailRouter.onSaveTodo = { [weak self] todo in
            self?.presenter?.todoDidUpdate(todo)
            self?.deattach(router: detailRouter)
            self?.navigationController?.dismiss(animated: true)
        }

        attachTo(router: detailRouter).start(with: .edit(element: todo))
    }

    func showNewDetail() {
        let detailRouter = DetailRouter()
        detailRouter.onSaveTodo = { [weak self] todo in
            self?.presenter?.todoDidAdd(todo)
            self?.deattach(router: detailRouter)
            self?.navigationController?.dismiss(animated: true)
        }

        attachTo(router: detailRouter).start(with: .new)
    }

    func start() -> UIViewController {
        let view = MainView.instantiate(from: .main)
        let navigationWrapped = view.wrappedInNavigation

        let presenter: MainScreenPresenter = MainPresenter()
        var interactor: MainScreenInteractor = MainInteractor()

        self.navigationController = navigationWrapped
        self.presenter = presenter
        view.presenter = presenter
        presenter.view = view
        presenter.router = self
        presenter.interactor = interactor
        interactor.presenter = presenter

        return navigationWrapped
    }
}
