import ReactiveSwift

/// Refreshableに準拠させることで、refresh()が呼べるようにある
public protocol VueFluxAdapterProtocol: Refreshable {
    var dataModel: Property<CountUpDataModel> { get }
    func incrementNumber()
}
