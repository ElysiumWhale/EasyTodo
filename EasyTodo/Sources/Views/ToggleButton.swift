import UIKit

@IBDesignable class ToggleButton: UIButton {
    @IBInspectable var highlightedImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let image = highlightedImage {
            setImage(image, for: [.highlighted, .selected])
        }
    }
    
    func setState(_ state: TodoStates) {
        isSelected = state == .done ? true : false
    }
}
