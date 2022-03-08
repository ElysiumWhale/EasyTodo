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
        let initial = UIStoryboard(id: .main).instantiateInitialViewController()

        guard let navigation = initial as? UINavigationController,
              let view = navigation.children.first as? MainView else {
                  return UINavigationController()
              }

        let presenter: MainScreenPresenter = MainPresenter()
        var interactor: MainScreenInteractor = MainInteractor()

        self.navigationController = navigation
        self.presenter = presenter
        view.presenter = presenter
        presenter.view = view
        presenter.router = self
        presenter.interactor = interactor
        interactor.presenter = presenter

        return navigation
    }
}
