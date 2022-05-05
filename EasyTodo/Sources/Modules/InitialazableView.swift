import Foundation

protocol InitialazableView {
    func addViews()
    func configureLayout()
    func configureAppearance()
    func localize()
    func configureActions()
}

extension InitialazableView {
    func initialize() {
        addViews()
        configureLayout()
        configureAppearance()
        localize()
        configureActions()
    }

    func addViews() { }

    func configureLayout() { }

    func configureAppearance() { }

    func localize() { }

    func configureActions() { }
}
