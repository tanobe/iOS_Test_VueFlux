import ReactiveSwift
import VueFlux
import Carbon
import UIKit

public extension PropertyProtocol {
    var property: Property<Value> {
        Property(self)
    }

    func combineOptionallyPrevious() -> Property<(Value?, Value)> {
        map(Optional.init)
            .combinePrevious(nil)
            .map { previous, next in
                (previous, next.unsafelyUnwrapped("The next value is always non optional"))
            }
    }
}
