import ReactiveCocoa
import ReactiveSwift

public extension Reactive where Base: AnyObject {
    func makeImmediateBindingTarget<T>(_ action: @escaping (Base, T) -> Void) -> BindingTarget<T> {
        makeBindingTarget(on: ImmediateScheduler(), action)
    }
}
