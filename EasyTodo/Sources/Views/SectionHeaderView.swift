import UIKit

class SectionHeaderView: UICollectionReusableView, InitialazableView {
    private let label = UILabel()

    var text: String? {
        get {
            label.text
        }
        set {
            label.text = newValue
        }
    }

    static var reuseIdentifier: String {
        UICollectionView.elementKindSectionHeader
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initialize()
    }

    func addViews() {
        addSubviews(label)
    }

    func configureLayout() {
        label.edgesToSuperview(insets: .horizontal(16))
    }

    func configureAppearance() {
        label.font = .avenirBlackFont(ofSize: 25)
    }
}
