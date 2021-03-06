import Foundation
import RxSwift

public struct Binding<T> {
	let observer: BehaviorSubject<[T]>
	let subscription: Disposable
	
	public func disposed(by disposeBag: DisposeBag) -> AnyObserver<[T]> {
		subscription.disposed(by: disposeBag)
		return observer.asObserver()
	}
}
