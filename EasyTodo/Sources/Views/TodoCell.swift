import UIKit

class TodoCell: UICollectionViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var toggleButton: ToggleButton!
    
    func configure(title: String, description: String, state: TodoStates) {
        layer.cornerRadius = 10
        toggleButton.setState(state)
        titleLabel.attributedText = state == .active ? NSAttributedString(string: title) : NSAttributedString(string: title, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        descriptionLabel.attributedText = state == .active ? NSAttributedString(string: description) : NSAttributedString(string: description, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
    }
}
