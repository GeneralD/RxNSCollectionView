import Cocoa
import RxSwift

struct CollectionViewCellBinder<Cell: NSCollectionViewItem>: ItemBinder where Cell: Reusable, Cell: Configurable {
	
	func bind(to ui: NSCollectionView) -> Binding<Cell.Model> {
		let source = BehaviorSubject(value: [Cell.Model]())
		let binding = source.bind(to: ui.rx.items(Cell.self))
		return Binding(observer: source, subscription: binding)
	}
}
