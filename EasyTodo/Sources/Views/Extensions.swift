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
