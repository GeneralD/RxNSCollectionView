import Cocoa

// MARK: Protocol Definition

/// Make your UIView subclasses conform to this protocol when:
///  * they *are* NIB-based, and
///  * this class is used as the XIB's root view
///
/// to be able to instantiate them from the NIB in a type-safe manner
public protocol NibLoadable: class {
	/// The nib file to use to load a new instance of the View designed in a XIB
	static var nib: NSNib { get }
}

// MARK: Default implementation

public extension NibLoadable {
	/// By default, use the nib which have the same name as the name of the class,
	/// and located in the bundle of that class
	static var nib: NSNib {
		NSNib(nibNamed: String(describing: self), bundle: Bundle(for: self))!
	}
}

// MARK: Support for instantiation from NIB

public extension NibLoadable where Self: NSView {
	/**
	Returns a `UIView` object instantiated from nib
	
	- returns: A `NibLoadable`, `UIView` instance
	*/
	static func loadFromNib() -> Self {
		var topObjects: NSArray? = []
		guard nib.instantiate(withOwner: nil, topLevelObjects: &topObjects), let view = topObjects?.firstObject as? Self else {
			fatalError("The nib \(nib) expected its root view to be of type \(self)")
		}
		return view
	}
}
