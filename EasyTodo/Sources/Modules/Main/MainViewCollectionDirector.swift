import UIKit

protocol MainViewCollectionInput: AnyObject {
    func configureHeader(view: SectionHeaderView, section: Int)
    func configureCell(_ cell: TodosCell, with todo: Todo)
    func model(for id: Todo.ID) -> Todo?
    func onSelectItem(at indexPath: IndexPath)
}

// Todo: Make fully generic base class
final class MainViewCollectionDirector: NSObject {
    let collectionView: UICollectionView

    private(set) lazy var dataSource = configureDataSource()

    weak var input: MainViewCollectionInput? {
        didSet {
            if input != nil {
                collectionView.dataSource = dataSource
            }
        }
    }

    init(collection: UICollectionView) {
        collectionView = collection
        super.init()
        collectionView.delegate = self
    }

    func configureDataSource() -> DataSource<MainViewSections, Todo.ID> {
        let cellRegistration = UICollectionView.CellRegistration<TodosCell, Todo> { [weak input] cell, _, todo in
            input?.configureCell(cell, with: todo)
        }

        let dataSource: DataSource<MainViewSections, Todo.ID> = DataSource(collectionView: collectionView) { [weak input] collectionView, indexPath, itemIdentifier in
            guard let todo = input?.model(for: itemIdentifier) else {
                return UICollectionViewCell()
            }

            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: todo)
        }
        dataSource.supplementaryViewProvider = makeHeaderProvider()

        return dataSource
    }

    private func makeHeaderProvider() -> SupplementaryViewProvider<MainViewSections, Todo.ID> {
        let kind = UICollectionView.elementKindSectionHeader
        let registration = SupplementaryRegistration<SectionHeaderView>(elementKind: kind) { [weak input] supplementaryView, hk, indexPath in

            input?.configureHeader(view: supplementaryView, section: indexPath.section)
        }

        return { collectionView, _, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: registration,
                                                                  for: indexPath)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewCollectionDirector: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        input?.onSelectItem(at: indexPath)
    }
}
