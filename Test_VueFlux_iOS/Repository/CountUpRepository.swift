import Foundation
import ReactiveSwift

protocol CountUpRepositoryProtocol: AnyObject {
    func refresh() -> SignalProducer<CountUpResponse, SomeError>
    func incrementNumber(number: Int, testArgument: String) -> SignalProducer<CountUpResponse, SomeError>
}

extension CountUpRepositoryProtocol {
    func incrementNumber(
        number: Int = 0,
        testArgument: String = "test"
    ) -> SignalProducer<CountUpResponse, SomeError> {
        incrementNumber(number: number, testArgument: testArgument)
    }
}

final class CountUpRepository: CountUpRepositoryProtocol {
//    private let api: hoge
//    init(api: hoge) {
//        self.api = api
//    }

    func refresh() -> SignalProducer<CountUpResponse, SomeError> {
        return SignalProducer(value: CountUpResponse.init(number: 0))
            .mapError(SomeError.init)
    }

    func incrementNumber(number: Int, testArgument _: String) -> SignalProducer<CountUpResponse, SomeError> {
        var count = number
        count += 1
        Thread.sleep(forTimeInterval: 2.0)

        return SignalProducer.init(value: CountUpResponse.init(number: count))
            .mapError(SomeError.init)
    }
}


enum SomeError: Error {
    case fetchError(Error)
    case SessionError
    init(error: Error) {
        self = .fetchError(error)
    }
}
