import ReactiveSwift

public protocol VueFluxAdapterProtocol: AnyObject {
    var dataModel: Property<CountUpDataModel> { get }
    func incrementNumber(number: Int)
    func refresh()
}
