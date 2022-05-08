import UIKit

// MARK: - FadeIn/Out UIView Animation
extension UIView {
    func fadeIn(_ duration: TimeInterval = 0.5) {
        if alpha == 0 {
            UIView.animate(withDuration: duration,
                           animations: { [weak self] in self?.alpha = 1 })
        }
    }

    func fadeOut(_ duration: TimeInterval = 0.5, completion: @escaping () -> Void = { }) {
        if alpha == 1 {
            UIView.animate(withDuration: duration,
                           animations: { [weak self] in self?.alpha = 0 },
                           completion: { _ in completion() }
            )
        }
    }
}

// MARK: - CreateBackground
extension UIViewController {
    func createBackground(labelText: String?) -> UILabel? {
        guard let text = labelText else { return nil }
        let label = UILabel()
        label.text = text
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        label.sizeToFit()
        return label
    }
}

// MARK: - UITextField error border
extension UITextField {
    func toggleErrorState(hasError: Bool, normalColor: CGColor? = nil) {
        layer.borderColor = hasError ? UIColor.systemRed.cgColor : normalColor ?? UIColor.clear.cgColor
        layer.borderWidth = hasError ? 1 : normalColor == nil ? 0 : 1
    }
}

// MARK: - Configuring shadow for cell
extension UICollectionViewCell {
    func configureShadow(with cornerRadius: CGFloat) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        //layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
}

// MARK: - Dismissing controls
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        swipe.cancelsTouchesInView = false
        swipe.direction = [.up, .down, .left, .right]
        view.addGestureRecognizer(swipe)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - AppTints
extension UIColor {
    enum AppTints: String {
        case main = "MainTint"
        case secondary = "SecondaryTint"
    }

    static func appTint(_ tint: AppTints) -> Self {
        self.init(named: tint.rawValue)!
    }
}

extension CGColor {
    static func appTint(_ tint: UIColor.AppTints) -> CGColor {
        UIColor.appTint(tint).cgColor
    }
}

// MARK: - Sugar init and instatiate
extension UIStoryboard {
    convenience init(id: Storyboards) {
        self.init(name: id.rawValue, bundle: .main)
    }

    func instantiate<ViewController: UIViewController>(id: String) -> ViewController {
        let controller = instantiateViewController(withIdentifier: id) as? ViewController
        guard let result = controller else {
            assertionFailure("Identifier \(id) is not mapped to type \(ViewController.Type.self)")
            return ViewController()
        }

        return result
    }
}

extension UICollectionView {
    func isEmpty(inSection: Int = .zero) -> Bool {
        numberOfItems(inSection: inSection) == .zero
    }

    func isNotEmpty(inSection: Int = .zero) -> Bool {
        !isEmpty(inSection: inSection)
    }
}

// MARK: - MainQueueRunnable sugar extension
protocol MainQueueRunnable { }

extension MainQueueRunnable {
    func dispatch(_ action: VoidClosure?) {
        DispatchQueue.main.async {
            action?()
        }
    }
}

extension UIViewController: MainQueueRunnable { }

// MARK: - Adding subviews
extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }

    func addSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addSubview(subview)
        }
    }
}

// MARK: - Wrapping navigation
extension UIViewController {
    var wrappedInNavigation: UINavigationController {
        UINavigationController(rootViewController: self)
    }
}

// MARK: - Avenir font
extension UIFont {
    static func avenirBlackFont(ofSize: CGFloat) -> UIFont {
        UIFont(name: "Avenir-Black", size: ofSize)!
    }
}

// MARK: - Compositional layouts
extension UICollectionViewLayout {
    static var mainViewCompositionalLayout: UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(130))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(140))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)

        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .estimated(30))

        let sectionHeader = SupplementaryItem(layoutSize: headerFooterSize,
                                              elementKind: UICollectionView.elementKindSectionHeader,
                                              alignment: .top)

        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
                case 0, 1:
                    let section = NSCollectionLayoutSection(group: group)
                    section.boundarySupplementaryItems = [sectionHeader]
                    section.interGroupSpacing = 10
                    return section
                default:
                    return NSCollectionLayoutSection(group: group)
            }
        }
    }
}
