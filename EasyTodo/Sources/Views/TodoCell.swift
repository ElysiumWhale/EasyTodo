import UIKit

protocol TodoCellDelegate {
    func todoCellDelegate(didToggle state: TodoStates, at index: Int)
}

class TodoCell: UICollectionViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var toggleButton: ToggleButton!
    
    private var index: Int = 0
    private var title: String = ""
    private var descr: String = ""
    
    var delegate: TodoCellDelegate?
    
    func configure(title: String, description: String, state: TodoStates, delegate: TodoCellDelegate, index: Int) {
        layer.cornerRadius = 10
        self.delegate = delegate
        self.index = index
        self.title = title
        self.descr = description
        toggleButton.todoState = state
        configureTextFor(state, title, description)
        configureShadow(with: 10)
    }
    
    private func configureTextFor(_ state: TodoStates, _ title: String, _ description: String) {
        titleLabel.attributedText = state == .active ? NSAttributedString(string: title) : NSAttributedString(string: title, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        descriptionLabel.attributedText = state == .active ? NSAttributedString(string: description) : NSAttributedString(string: description, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
    }
    
    @IBAction private func toggleButtonDidPress(sender: ToggleButton?) {
        toggleButton.toggle()
        configureTextFor(toggleButton.todoState, title, descr)
        delegate?.todoCellDelegate(didToggle: toggleButton.todoState, at: index)
    }
}
