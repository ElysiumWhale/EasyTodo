import UIKit

class DetailView: UIViewController, DetailScreenView {
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var actionButton: UIButton!
    @IBOutlet private var navBar: UINavigationBar!

    var presenter: DetailScreenPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureAppearance()
        presenter?.viewDidLoad()
    }
    
    @IBAction func textDidChanged(sender: Any?) {
        if let textField = sender as? UITextField {
            textField.toggleErrorState(hasError: textField.text == nil || textField.text!.isEmpty,
                                       normalColor: .appTint(.main))
            actionButton.isEnabled = textField.text != nil && !textField.text!.isEmpty
            actionButton.backgroundColor = actionButton.isEnabled ? .appTint(.main) : .gray
            return
        }
    }

    @IBAction func closeDidPress(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func saveDidPressed(sender: UIButton?) {
        guard let title = titleTextField.text, !title.isEmpty else {
            textDidChanged(sender: titleTextField)
            return
        }

        presenter?.saveTodo(title: title, description: descriptionTextView.text)
    }

    func showDetails(_ title: String, _ description: String, _ date: Date, isNew: Bool) {
        let dateForm = DateFormatter()
        dateForm.dateFormat = .displayDateMask
        dateLabel.text = dateForm.string(from: date)
        titleTextField.text = title
        descriptionTextView.text = description
        actionButton.setTitle(isNew ? "Add" : "Save", for: .normal)
        navBar.topItem?.title = isNew ? "Create" : "Todo"
        actionButton.fadeIn()
    }

    private func configureAppearance() {
        actionButton.alpha = .zero
        titleTextField.layer.cornerRadius = 5
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = .appTint(.main)
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = .appTint(.main)
        actionButton.layer.cornerRadius = 10
    }
}
