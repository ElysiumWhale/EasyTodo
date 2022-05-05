import UIKit

class InputTextField: UITextField {
    var textLeftInset: CGFloat = 5

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds).inset(by: .left(textLeftInset))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds).inset(by: .left(textLeftInset))
    }
}
