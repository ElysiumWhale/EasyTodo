import UIKit
import TinyConstraints

final class DetailView: InitialazableViewController, DetailScreenView {
    private let barButton = UIBarButtonItem()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let titleTextField = InputTextField()
    private let descriptionLabel = UILabel()
    private let descriptionTextView = UITextView()
    private let actionButton = UIButton()

    var presenter: DetailScreenPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
    }

    override func addViews() {
        navigationItem.rightBarButtonItem = barButton

        view.addSubviews(titleLabel,
                         dateLabel,
                         titleTextField,
                         descriptionLabel,
                         descriptionTextView,
                         actionButton)
    }

    override func configureLayout() {
        titleLabel.topToSuperview(offset: 10, usingSafeArea: true)
        titleLabel.leftToSuperview(offset: 16)

        dateLabel.leftToRight(of: titleLabel, offset: 10)
        dateLabel.rightToSuperview(offset: -16)
        dateLabel.topToSuperview(offset: 10, usingSafeArea: true)

        titleTextField.topToBottom(of: titleLabel, offset: 10)
        titleTextField.horizontalToSuperview(insets: .horizontal(16))
        titleTextField.height(45)

        descriptionLabel.topToBottom(of: titleTextField, offset: 20)
        descriptionLabel.leftToSuperview(offset: 16)

        descriptionTextView.topToBottom(of: descriptionLabel, offset: 10)
        descriptionTextView.horizontalToSuperview(insets: .horizontal(16))
        descriptionTextView.height(300)

        actionButton.topToBottom(of: descriptionTextView, offset: 10)
        actionButton.centerX(to: descriptionTextView)
        actionButton.size(.init(width: 150, height: 45))
    }

    override func configureAppearance() {
        view.backgroundColor = .systemBackground

        titleTextField.layer.cornerRadius = 5
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = .appTint(.main)
        titleTextField.font = .systemFont(ofSize: 18, weight: .semibold)

        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = .appTint(.main)
        descriptionTextView.font = .systemFont(ofSize: 18, weight: .semibold)

        actionButton.backgroundColor = .appTint(.secondary)
        actionButton.layer.cornerRadius = 10
        actionButton.titleLabel?.font = .avenirBlackFont(ofSize: 23)

        barButton.image = UIImage(systemName: "xmark")
        barButton.tintColor = .appTint(.secondary)

        dateLabel.font = .avenirBlackFont(ofSize: 30)
        dateLabel.textColor = .appTint(.secondary)

        titleLabel.font = .avenirBlackFont(ofSize: 30)
        titleLabel.textColor = .appTint(.main)

        descriptionLabel.font = .avenirBlackFont(ofSize: 30)
        descriptionLabel.textColor = .appTint(.main)
    }

    override func localize() {
        titleLabel.text = "Title"
        titleTextField.placeholder = "Enter title for todo"
        descriptionLabel.text = "Description"

        configureText(with: presenter?.todo)
    }

    override func configureActions() {
        barButton.target = self
        barButton.action = #selector(closeDidPress)
        titleTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        actionButton.addTarget(self, action: #selector(saveDidPressed), for: .touchUpInside)
    }

    // MARK: - Private methods
    private func configureText(with todo: Todo?) {
        let isNew = todo == nil
        actionButton.setTitle(isNew ? "Add" : "Save", for: .normal)
        navigationItem.title = isNew ? "Create todo" : "Details"
        descriptionTextView.text = todo?.description
        titleTextField.text = todo?.title
        dateLabel.text = (todo?.creationDate ?? Date()).formatted(with: .displayDateMask)
    }

    @objc private func textDidChange(sender: UITextField?) {
        guard let textField = sender else {
            return
        }

        textField.toggleErrorState(hasError: textField.text == nil || textField.text!.isEmpty,
                                   normalColor: .appTint(.main))
        actionButton.isEnabled = textField.text != nil && !textField.text!.isEmpty
        actionButton.backgroundColor = actionButton.isEnabled ? .appTint(.main) : .gray
    }

    @objc private func closeDidPress(_ sender: Any) {
        dismiss(animated: true)
    }

    @objc private func saveDidPressed(sender: UIButton?) {
        guard let title = titleTextField.text, !title.isEmpty else {
            textDidChange(sender: titleTextField)
            return
        }

        presenter?.saveTodo(title: title, description: descriptionTextView.text)
    }
}
