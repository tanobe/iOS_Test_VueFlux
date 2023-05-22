import ReactiveSwift
import UIKit

public extension Reactive where Base: UIControl {
    var tap: Signal<Void, Never> {
        controlEvents(.touchUpInside).map(value: ())
    }

    var touchDown: Signal<Void, Never> {
        controlEvents(.touchDown).map(value: ())
    }
}
