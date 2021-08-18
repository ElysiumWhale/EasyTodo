import UIKit

class DetailView: UIViewController {
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var addButton: UIButton!
    
    var presenter: DetailScreenPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        addButton.alpha = 0
        titleTextField.layer.cornerRadius = 5
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = UIColor(.main).cgColor
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor(.main).cgColor
        addButton.layer.cornerRadius = 10
        presenter?.viewDidLoad()
    }
    
    @IBAction func textDidChanged(sender: Any?) {
        if let textField = sender as? UITextField {
            textField.toggleErrorState(hasError: textField.text == nil || textField.text!.isEmpty, normalColor: UIColor(.main).cgColor)
            addButton.isEnabled = textField.text != nil && !textField.text!.isEmpty
            addButton.backgroundColor = addButton.isEnabled ? UIColor(.secondary) : .gray
            return
        }
    }
    
    @IBAction func saveDidPressed(sender: UIButton?) {
        guard let title = titleTextField.text, !title.isEmpty else {
            textDidChanged(sender: titleTextField)
            return
        }
        
        presenter?.saveNewTodo(with: title, and: descriptionTextView.text)
        dismiss(animated: true)
    }
}

extension DetailView: DetailScreenView {
    func showDetails(_ title: String, _ description: String, _ date: Date, isNew: Bool) {
        let dateForm = DateFormatter()
        dateForm.dateFormat = "dd.MM.yyyy"
        dateLabel.text = dateForm.string(from: date)
        titleTextField.text = title
        descriptionTextView.text = description
        addButton.setTitle(isNew ? "Add" : "Save", for: .normal)
        if isNew {
            addButton.fadeIn()
        }
    }
}
