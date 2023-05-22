import ReactiveSwift
import VueFlux


// StateProtocol。ActionとMutationのみで構成されるよう制限。
// fileprivateで制限し、mutationのみでfileprivateのプロパティの変更が加えられる

extension Computed where State == VueFluxState {
    var dataModel: Property<CountUpDataModel> {
        state.dataModel.property
    }
}

final class VueFluxState: State {
    typealias Mutations = VueFluxMutations

    //  associatedtype Mutations: VueFlux.Mutations where Mutations.State == Self
    enum Action {
        case loading
        case loaded(Result<CountUpResponse, SomeError>)
    }

    struct IntClass {
        let number: Int
    }
    fileprivate let dataModel = MutableProperty(CountUpDataModel(number: .init()))
}



struct VueFluxMutations: Mutations {
    // associatedtype State: VueFlux.State
    // func commit(action: State.Action, state: State)
    func commit(action: VueFluxState.Action, state: VueFluxState) {
        switch action {
        case .loading:
            print("loading")
        case .loaded(.success(let response)):
            print("loaded")
            state.dataModel.modify { dataModel in
                dataModel.number = String(response.number)
            }
        case .loaded(.failure(let error)):
            print(error)
        }
    }
}
