//
//  RxCollectionViewDataSourceProxy.swift
//  General Store
//
//  Created by Yumenosuke Koukata on 2020/05/15.
//  Copyright © 2020 ZYXW. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

extension NSCollectionView: HasDataSource {
	public typealias DataSource = NSCollectionViewDataSource
}

private let collectionViewDataSourceNotSet = CollectionViewDataSourceNotSet()

private final class CollectionViewDataSourceNotSet: NSObject, NSCollectionViewDataSource {
	
	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		0
	}
	
	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		rxAbstractMethod(message: dataSourceNotSet)
	}
}

/// For more information take a look at `DelegateProxyType`.
open class RxCollectionViewDataSourceProxy: DelegateProxy<NSCollectionView, NSCollectionViewDataSource>, DelegateProxyType, NSCollectionViewDataSource {
	
	/// Typed parent object.
	public weak private(set) var collectionView: NSCollectionView?
	
	/// - parameter collectionView: Parent object for delegate proxy.
	public init(collectionView: ParentObject) {
		self.collectionView = collectionView
		super.init(parentObject: collectionView, delegateProxy: RxCollectionViewDataSourceProxy.self)
	}
	
	// Register known implementations
	public static func registerKnownImplementations() {
		self.register { RxCollectionViewDataSourceProxy(collectionView: $0) }
	}
	
	private weak var _requiredMethodsDataSource: NSCollectionViewDataSource? = collectionViewDataSourceNotSet
	
	// MARK: delegate
	/// Required delegate method implementation.
	public func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		(_requiredMethodsDataSource ?? collectionViewDataSourceNotSet).collectionView(collectionView, numberOfItemsInSection: section)
	}
	
	/// Required delegate method implementation.
	public func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		(_requiredMethodsDataSource ?? collectionViewDataSourceNotSet).collectionView(collectionView, itemForRepresentedObjectAt: indexPath)
	}
	
	/// For more information take a look at `DelegateProxyType`.
	open override func setForwardToDelegate(_ delegate: NSCollectionViewDataSource?, retainDelegate: Bool) {
		_requiredMethodsDataSource = delegate ?? collectionViewDataSourceNotSet
		super.setForwardToDelegate(delegate, retainDelegate: retainDelegate)
	}
}
