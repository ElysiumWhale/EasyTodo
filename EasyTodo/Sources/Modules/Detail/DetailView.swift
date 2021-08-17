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
        titleTextField.layer.borderColor = UIColor(named: "MainTint")!.cgColor
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor(named: "MainTint")!.cgColor
        addButton.layer.cornerRadius = 10
        presenter?.viewDidLoad()
    }
}

extension DetailView: DetailScreenView {
    func showDetails(for todo: Todo) {
        let dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd"
        dateLabel.text = dateForm.string(from: todo.creationDate)
        titleTextField.text = todo.title
        descriptionTextView.text = todo.description
    }
}
