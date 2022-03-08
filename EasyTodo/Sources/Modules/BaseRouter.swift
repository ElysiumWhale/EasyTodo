import UIKit

protocol Routable: AnyObject {
    var navigationController: UINavigationController? { get set }
    var route: [Routable] { get set }
    func attachTo<T: Routable>(router: T) -> T
}

class BaseRouter: Routable {
    var navigationController: UINavigationController?
    var route: [Routable] = []

    func attachTo<T: Routable>(router: T) -> T {
        router.navigationController = navigationController
        route.append(router)
        return router
    }

    func deattach(router: Routable) {
        guard let index = route.firstIndex(where: { router === $0 }) else {
            return
        }

        route.remove(at: index)
    }
}
