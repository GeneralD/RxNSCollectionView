import Foundation

public protocol HasDelegate: AnyObject {
	associatedtype Delegate
	var delegate: Delegate? { get set }
}
