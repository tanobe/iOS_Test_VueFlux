import class VueFlux.AtomicReference

/// Represents an observable value that can be change directly.
public final class Variable<Value> {
    /// Create a constant which reflects the `self`.
    public var constant: Constant<Value> {
        return .init(variable: self)
    }
    
    /// Create a signal to forwards the current value at observation and the all value changes.
    public var signal: Signal<Value> {
        return .init { send in
            self._value.synchronized { value in
                send(value)
                return self.changesSignal.observe(send)
            }
        }
    }
    
    /// The current value.
    /// Setting this to a new value will send to signal.
    public var value: Value {
        get {
            return _value.value
        }
        set {
            _value.modify { value in
                value = newValue
                changesSink.send(value: value)
            }
        }
    }
    
    private let changesSink = Sink<Value>()
    private lazy var changesSignal = changesSink.signal
    private let _value: AtomicReference<Value>
    
    /// Create a new variable with its initial value.
    ///
    /// - Parameters:
    ///   - value: An initial value.
    public init(_ value: Value) {
        _value = .init(value)
    }
}
