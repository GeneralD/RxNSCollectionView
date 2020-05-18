import Foundation

public protocol HasDelegate: class {
	associatedtype Delegate
	var delegate: Delegate? { get set }
}
