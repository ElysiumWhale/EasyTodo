import UIKit

typealias VoidClosure = () -> Void
typealias ParameterClosure<T> = (T) -> Void
typealias DataSource<T1: Hashable, T2: Hashable> = UICollectionViewDiffableDataSource<T1, T2>
typealias SupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem
typealias SupplementaryViewProvider<T1: Hashable, T2: Hashable> = UICollectionViewDiffableDataSource<T1, T2>.SupplementaryViewProvider
typealias SupplementaryRegistration<T: UICollectionReusableView> = UICollectionView.SupplementaryRegistration<T>
