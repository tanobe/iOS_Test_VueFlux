import ReactiveSwift

public protocol Refreshable: AnyObject, ReactiveExtensionsProvider {
    func refresh()
}

/// base にadapterが来る
public extension Refreshable {
    var refresh: BindingTarget<Void> {
        reactive.makeImmediateBindingTarget { base, _ in
            base.refresh()
        }
    }
}

