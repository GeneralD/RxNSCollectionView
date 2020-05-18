import Cocoa

public protocol CollectionViewCellFactory {
	associatedtype Model
	
	func create(collectionView: NSCollectionView, indexPath: IndexPath, model: Model) -> NSCollectionViewItem
}
