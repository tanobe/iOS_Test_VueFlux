import VueFlux

public extension Store {
    convenience init(state: State, mutations: State.Mutations) {
        self.init(state: state, mutations: mutations, executor: .mainThread)
    }
}
