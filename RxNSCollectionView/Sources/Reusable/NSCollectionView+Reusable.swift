import Cocoa

// MARK: Reusable support for UICollectionView

public extension NSCollectionView {
	/**
	Register a NIB-Based `UICollectionViewCell` subclass (conforming to `Reusable` & `NibLoadable`)
	
	- parameter itemType: the `UICollectionViewCell` (`Reusable` & `NibLoadable`-conforming) subclass to register
	
	- seealso: `register(_:,forCellWithReuseIdentifier:)`
	*/
	final func register<T: NSCollectionViewItem>(itemType: T.Type)
		where T: Reusable & NibLoadable {
			register(itemType.nib, forItemWithIdentifier: itemType.reuseIdentifier)
	}
	
	/**
	Register a Class-Based `UICollectionViewCell` subclass (conforming to `Reusable`)
	
	- parameter itemType: the `UICollectionViewCell` (`Reusable`-conforming) subclass to register
	
	- seealso: `register(_:,forCellWithReuseIdentifier:)`
	*/
	final func register<T: NSCollectionViewItem>(itemType: T.Type)
		where T: Reusable {
			register(itemType.self, forItemWithIdentifier: itemType.reuseIdentifier)
	}
	
	/**
	Returns a reusable `UICollectionViewCell` object for the class inferred by the return-type
	
	- parameter indexPath: The index path specifying the location of the cell.
	- parameter itemType: The cell class to dequeue
	
	- returns: A `Reusable`, `UICollectionViewCell` instance
	
	- note: The `itemType` parameter can generally be omitted and infered by the return type,
	except when your type is in a variable and cannot be determined at compile time.
	- seealso: `dequeueReusableCell(withReuseIdentifier:,for:)`
	*/
	final func dequeueReusableCell<T: NSCollectionViewItem>(for indexPath: IndexPath, itemType: T.Type = T.self) -> T
		where T: Reusable {
			
			let bareCell = makeItem(withIdentifier: itemType.reuseIdentifier, for: indexPath)
			guard let cell = bareCell as? T else {
				fatalError(
					"Failed to dequeue a cell with identifier \(itemType.reuseIdentifier) matching type \(itemType.self). "
						+ "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
						+ "and that you registered the cell beforehand"
				)
			}
			return cell
	}
	
	/**
	Register a NIB-Based `UICollectionReusableView` subclass (conforming to `Reusable` & `NibLoadable`)
	as a Supplementary View
	
	- parameter supplementaryViewType: the `UIView` (`Reusable` & `NibLoadable`-conforming) subclass
	to register as Supplementary View
	- parameter elementKind: The kind of supplementary view to create.
	
	- seealso: `register(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
	*/
	final func register<T: NSCollectionViewElement>(supplementaryViewType: T.Type, ofKind elementKind: SupplementaryElementKind)
		where T: Reusable & NibLoadable {
			register(supplementaryViewType.nib, forSupplementaryViewOfKind: elementKind, withIdentifier: supplementaryViewType.reuseIdentifier)
	}
	
	/**
	Register a Class-Based `UICollectionReusableView` subclass (conforming to `Reusable`) as a Supplementary View
	
	- parameter supplementaryViewType: the `UIView` (`Reusable`-conforming) subclass to register as Supplementary View
	- parameter elementKind: The kind of supplementary view to create.
	
	- seealso: `register(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
	*/
	final func register<T: NSCollectionViewElement>(supplementaryViewType: T.Type, ofKind elementKind: SupplementaryElementKind)
		where T: Reusable {
			register(supplementaryViewType.self, forSupplementaryViewOfKind: elementKind, withIdentifier: supplementaryViewType.reuseIdentifier)
	}
	
	/**
	Returns a reusable `UICollectionReusableView` object for the class inferred by the return-type
	
	- parameter elementKind: The kind of supplementary view to retrieve.
	- parameter indexPath:   The index path specifying the location of the cell.
	- parameter viewType: The view class to dequeue
	
	- returns: A `Reusable`, `UICollectionReusableView` instance
	
	- note: The `viewType` parameter can generally be omitted and infered by the return type,
	except when your type is in a variable and cannot be determined at compile time.
	- seealso: `dequeueReusableSupplementaryView(ofKind:,withReuseIdentifier:,for:)`
	*/
	final func dequeueReusableSupplementaryView<T: NSCollectionViewElement>(ofKind elementKind: SupplementaryElementKind, for indexPath: IndexPath, viewType: T.Type = T.self) -> T
		where T: Reusable {
			let view = supplementaryView(forElementKind: elementKind, at: indexPath)
			guard let typedView = view as? T else {
				fatalError(
					"Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
						+ "matching type \(viewType.self). "
						+ "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
						+ "and that you registered the supplementary view beforehand"
				)
			}
			return typedView
	}
}
