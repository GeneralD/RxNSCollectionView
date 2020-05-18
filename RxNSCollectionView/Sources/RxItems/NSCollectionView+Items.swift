import Cocoa
import RxSwift
import RxCocoa

public extension Reactive where Base: NSCollectionView {
	func items<S: Sequence, Cell: NSCollectionViewItem, O: ObservableType>(_: Cell.Type)
		-> (_ _: O)
		-> Disposable
		where O.Element == S, Cell: Reusable & Configurable, Cell.Model == S.Iterator.Element {
			return { source in
				return source.bind(to: self.items(cellIdentifier: Cell.reuseIdentifier, cellType: Cell.self)) { (_, model, cell) in
					cell.configure(with: model)
				}
			}
	}
	
	func items<S: Sequence, Cell: NSCollectionViewItem, O: ObservableType>(_: Cell.Type, withDelegate delegate: Cell.Delegate)
		-> (_ _: O)
		-> Disposable
		where O.Element == S, Cell: HasDelegate & Reusable & Configurable, Cell.Model == S.Iterator.Element {
			return { source in
				return source.bind(to: self.items(cellIdentifier: Cell.reuseIdentifier, cellType: Cell.self)) { (_, model, cell) in
					cell.delegate = delegate
					cell.configure(with: model)
				}
			}
	}
	
	func items<F: CollectionViewCellFactory, S: Sequence, O: ObservableType>(using factory: F)
		-> (_ _: O)
		-> Disposable
		where O.Element == S, F.Model == S.Iterator.Element {
			return { (source) in
				let items = self.items(source)
				return items { (collectionView, index, model) in
					let indexPath = IndexPath(item: index, section: 0)
					return factory.create(collectionView: collectionView, indexPath: indexPath, model: model)
				}
			}
	}
	
	func items<Cell: NSCollectionViewItem>(type: Cell.Type) -> Binding<Cell.Model> where Cell: Reusable & Configurable {
		return CollectionViewCellBinder<Cell>().bind(to: base)
	}
	
	func items<Cell: NSCollectionViewItem>(type: Cell.Type, withDelegate delegate: Cell.Delegate) -> Binding<Cell.Model> where Cell: HasDelegate & Reusable & Configurable {
		return CollectionViewCellFactoryBinder(factory: CollectionViewCellWithDelegateFactory<Cell>(delegate: delegate)).bind(to: base)
	}
	
	func items<Factory: CollectionViewCellFactory>(factory: Factory) -> Binding<Factory.Model> {
		return CollectionViewCellFactoryBinder(factory: factory).bind(to: base)
	}
}
