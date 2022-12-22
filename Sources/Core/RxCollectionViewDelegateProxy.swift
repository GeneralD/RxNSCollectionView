//
//  RxCollectionViewDelegateProxy.swift
//  
//
//  Created by JH on 2022/12/20.
//

import Cocoa
import RxSwift
import RxCocoa

extension NSCollectionView: RxCocoa.HasDelegate {
    public typealias Delegate = NSCollectionViewDelegate
}


class RxCollectionViewDelegateProxy: DelegateProxy<NSCollectionView, NSCollectionViewDelegate>, DelegateProxyType, NSCollectionViewDelegate {
    
    public weak private(set) var collectionView: NSCollectionView?
    
    public init(collectionView: ParentObject) {
        self.collectionView = collectionView
        super.init(parentObject: collectionView, delegateProxy: RxCollectionViewDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { RxCollectionViewDelegateProxy(collectionView: $0) }
    }
    
}
