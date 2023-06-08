public extension Optional {
    var isSome: Bool {
        guard case .some = self else { return false }
        return true
    }

    var isNone: Bool {
        self == nil
    }

    func unsafelyUnwrapped(_ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> Wrapped {
        guard let wrapped = self else {
            fatalError(message(), file: file, line: line)
        }
        return wrapped
    }
}
