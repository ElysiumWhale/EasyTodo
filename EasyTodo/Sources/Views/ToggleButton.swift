import UIKit

@IBDesignable class ToggleButton: UIButton {
    @IBInspectable var highlightedImage: UIImage?
    
    var todoState: TodoStates = .active {
        didSet {
            isSelected = todoState == .done ? true : false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let image = highlightedImage {
            setImage(image, for: [.highlighted, .selected])
        }
    }
    
    func toggle() {
        todoState = todoState == .active ? .done : .active
    }
}
