import UIKit

@IBDesignable class ToggleButton: UIButton {
    @IBInspectable var highlightedImage: UIImage?

    var isToggled: Bool = false {
        didSet {
            isSelected = isToggled
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        if let image = highlightedImage {
            setImage(image, for: [.highlighted, .selected])
        }
    }

    func toggle() {
        isToggled = !isToggled
    }
}
