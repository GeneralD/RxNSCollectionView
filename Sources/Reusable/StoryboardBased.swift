import Cocoa

// MARK: Protocol Definition

/// Make your NSViewController subclasses conform to this protocol when:
///  * they *are* Storyboard-based, and
///  * this ViewController is the initialViewController of your Storyboard
///
/// to be able to instantiate them from the Storyboard in a type-safe manner
public protocol StoryboardBased: class {
	/// The NSStoryboard to use when we want to instantiate this ViewController
	static var sceneStoryboard: NSStoryboard { get }
}

// MARK: Default Implementation

public extension StoryboardBased {
	/// By default, use the storybaord with the same name as the class
	static var sceneStoryboard: NSStoryboard {
		.init(name: String(describing: self), bundle: Bundle(for: self))
	}
}

// MARK: Support for instantiation from Storyboard

public extension StoryboardBased where Self: NSViewController {
	/**
	Create an instance of the ViewController from its associated Storyboard's initialViewController
	
	- returns: instance of the conforming ViewController
	*/
	static func instantiate() -> Self {
		let viewController = sceneStoryboard.instantiateInitialController()
		guard let typedViewController = viewController as? Self else {
			fatalError("The initialViewController of '\(sceneStoryboard)' is not of class '\(self)'")
		}
		return typedViewController
	}
}
