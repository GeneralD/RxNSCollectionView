//
//  RxCollectionViewReactiveArrayDataSource.swift
//  General Store
//
//  Created by Yumenosuke Koukata on 2020/05/15.
//  Copyright © 2020 ZYXW. All rights reserved.
//

import RxSwift
import RxCocoa

// objc monkey business
class _RxCollectionViewReactiveArrayDataSource: NSObject, NSCollectionViewDataSource {
	
	@objc(numberOfSectionsInCollectionView:)
	func numberOfSections(in collectionView: NSCollectionView) -> Int {
		1
	}
	
	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		_collectionView(collectionView, numberOfItemsInSection: section)
	}
	
	func _collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		0
	}
	
	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		_collectionView(collectionView, itemForRepresentedObjectAt: indexPath)
	}
	
	func _collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		rxAbstractMethod()
	}
}

class RxCollectionViewReactiveArrayDataSourceSequenceWrapper<Sequence: Swift.Sequence>: RxCollectionViewReactiveArrayDataSource<Sequence.Element>, RxCollectionViewDataSourceType {
	typealias Element = Sequence
	
	override init(cellFactory: @escaping CellFactory) {
		super.init(cellFactory: cellFactory)
	}
	
	func collectionView(_ collectionView: NSCollectionView, observedEvent: Event<Sequence>) {
		Binder(self) { collectionViewDataSource, sectionModels in
			let sections = Array(sectionModels)
			collectionViewDataSource.collectionView(collectionView, observedElements: sections)
		}.on(observedEvent)
	}
}


// Please take a look at `DelegateProxyType.swift`
class RxCollectionViewReactiveArrayDataSource<Element>: _RxCollectionViewReactiveArrayDataSource, SectionedViewDataSourceType {
	
	typealias CellFactory = (NSCollectionView, Int, Element) -> NSCollectionViewItem
	
	var itemModels: [Element]?
	
	func modelAtIndex(_ index: Int) -> Element? {
		return itemModels?[index]
	}
	
	func model(at indexPath: IndexPath) throws -> Any {
		precondition(indexPath.section == 0)
		guard let item = itemModels?[indexPath.item] else {
			throw RxCocoaError.itemsNotYetBound(object: self)
		}
		return item
	}
	
	var cellFactory: CellFactory
	
	init(cellFactory: @escaping CellFactory) {
		self.cellFactory = cellFactory
	}
	
	// data source
	
	override func _collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		itemModels?.count ?? 0
	}
	
	override func _collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		cellFactory(collectionView, indexPath.item, itemModels![indexPath.item])
	}
	
	// reactive
	
	func collectionView(_ collectionView: NSCollectionView, observedElements: [Element]) {
		self.itemModels = observedElements
		
		collectionView.reloadData()
		
		collectionView.collectionViewLayout?.invalidateLayout()
	}
}
