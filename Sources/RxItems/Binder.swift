import Foundation

protocol ItemBinder {
	associatedtype Model
	associatedtype UI
	
	func bind(to ui: UI) -> Binding<Model>
}
