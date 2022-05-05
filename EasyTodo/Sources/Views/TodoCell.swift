import UIKit

protocol TodoCellDelegate: AnyObject {
    func todoCellDelegate(didToggle state: TodoStates, at index: Int)
}

class TodoCell: UICollectionViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var toggleButton: ToggleButton!

    private var index: Int = .zero
    private var title: String = .empty
    private var descr: String = .empty

    var onToggle: ParameterClosure<(state: TodoStates, index: Int)>?

    func configure(title: String, description: String, state: TodoStates, index: Int) {
        layer.cornerRadius = 10
        self.index = index
        self.title = title
        self.descr = description
        toggleButton.todoState = state
        configureTextFor(state, title, description)
        configureShadow(with: 10)
    }

    private func configureTextFor(_ state: TodoStates, _ title: String, _ description: String) {
        let attributes = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        titleLabel.attributedText = .attributed(title,
                                                shouldUseAttributes: state == .active,
                                                attributes: attributes)
        descriptionLabel.attributedText = .attributed(description,
                                                      shouldUseAttributes: state == .active,
                                                      attributes: attributes)
    }

    @IBAction private func toggleButtonDidPress(sender: ToggleButton?) {
        toggleButton.toggle()
        configureTextFor(toggleButton.todoState, title, descr)
        onToggle?((state: toggleButton.todoState, index: index))
    }
}

private extension NSAttributedString {
    static func attributed(_ string: String,
                           shouldUseAttributes: Bool,
                           attributes: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString {
        shouldUseAttributes
            ? NSAttributedString(string: string)
            : NSAttributedString(string: string, attributes: attributes)
    }
}
