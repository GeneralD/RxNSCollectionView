import Foundation

public protocol Configurable {
	associatedtype Model
	func configure(with model: Model)
}
