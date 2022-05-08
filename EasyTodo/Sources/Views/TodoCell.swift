import UIKit

final class TodosCell: UICollectionViewCell, InitialazableView {
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let toggleButton = ToggleButton()

    private(set) var model: Todo?
    private(set) var onToggle: VoidClosure?

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initialize()
    }

    func configure(model: Todo, onToggle: VoidClosure?) {
        self.model = model
        self.onToggle = onToggle
        toggleButton.isToggled = model.state == .done
        configureText(model.state, model.title, model.description)
    }

    func addViews() {
        addSubviews(titleLabel, descriptionLabel, toggleButton)
    }

    func configureLayout() {
        toggleButton.leftToSuperview(offset: 8)
        toggleButton.topToSuperview(offset: 8)
        toggleButton.size(.init(width: 25, height: 25))

        titleLabel.leftToRight(of: toggleButton, offset: 8)
        titleLabel.centerY(to: toggleButton)
        titleLabel.rightToSuperview(offset: -8)
        titleLabel.height(30)

        descriptionLabel.topToBottom(of: titleLabel, offset: 8)
        descriptionLabel.bottomToSuperview(offset: -8)
        descriptionLabel.rightToSuperview(offset: -8)
        descriptionLabel.left(to: titleLabel)
        descriptionLabel.height(70, relation: .equalOrLess)
    }

    func configureAppearance() {
        toggleButton.tintColor = .appTint(.main)
        toggleButton.contentMode = .scaleToFill
        toggleButton.contentVerticalAlignment = .fill
        toggleButton.contentHorizontalAlignment = .fill
        toggleButton.setImage(UIImage(systemName: "checkmark.circle.fill"),
                              for: .selected)
        toggleButton.setImage(.init(systemName: "circle"), for: .normal)

        titleLabel.font = .avenirBlackFont(ofSize: 20)
        titleLabel.textAlignment = .left

        descriptionLabel.numberOfLines = 4
        descriptionLabel.lineBreakMode = .byWordWrapping

        backgroundColor = .appTint(.secondary)
        layer.cornerRadius = 10
    }

    func configureActions() {
        toggleButton.addTarget(self,
                               action: #selector(toggleButtonDidPress),
                               for: .touchUpInside)
    }

    @objc private func toggleButtonDidPress(sender: ToggleButton?) {
        guard let todo = model else {
            return
        }

        toggleButton.toggle()
        todo.toggle()
        configureText(todo.state, todo.title, todo.description)
        onToggle?()
    }

    private func configureText(_ state: TodoStates?, _ title: String, _ description: String) {
        let attributes = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        titleLabel.attributedText = .attributed(title,
                                                shouldUseAttributes: state == .active,
                                                attributes: attributes)
        descriptionLabel.attributedText = .attributed(description,
                                                      shouldUseAttributes: state == .active,
                                                      attributes: attributes)
    }
}
