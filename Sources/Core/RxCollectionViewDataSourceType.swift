//
//  RxCollectionViewDataSourceType.swift
//  General Store
//
//  Created by Yumenosuke Koukata on 2020/05/15.
//  Copyright © 2020 ZYXW. All rights reserved.
//

import Cocoa
import RxSwift

/// Marks data source as `NSCollectionView` reactive data source enabling it to be used with one of the `bindTo` methods.
public protocol RxCollectionViewDataSourceType /*: NSCollectionViewDataSource*/ {
	
	/// Type of elements that can be bound to collection view.
	associatedtype Element
	
	/// New observable sequence event observed.
	///
	/// - parameter collectionView: Bound collection view.
	/// - parameter observedEvent: Event
	func collectionView(_ collectionView: NSCollectionView, observedEvent: Event<Element>)
}
