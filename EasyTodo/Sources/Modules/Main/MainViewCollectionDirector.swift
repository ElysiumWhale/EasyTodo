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

    private(set) var dataSource: DataSource<MainViewSections, Todo.ID>! {
        didSet {
            collectionView.dataSource = dataSource
        }
    }

    weak var input: MainViewCollectionInput?

    init(collection: UICollectionView) {
        collectionView = collection
        super.init()
        collectionView.delegate = self
        dataSource = makeDataSource()
    }

    func makeDataSource() -> DataSource<MainViewSections, Todo.ID> {
        let cellRegistration = UICollectionView.CellRegistration<TodosCell, Todo> { [weak self] cell, _, todo in
            self?.input?.configureCell(cell, with: todo)
        }

        let dataSource = DataSource<MainViewSections, Todo.ID>(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let todo = self?.input?.model(for: itemIdentifier) else {
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
        let registration = SupplementaryRegistration<SectionHeaderView>(elementKind: kind) { [weak self] supplementaryView, _, indexPath in

            self?.input?.configureHeader(view: supplementaryView, section: indexPath.section)
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
