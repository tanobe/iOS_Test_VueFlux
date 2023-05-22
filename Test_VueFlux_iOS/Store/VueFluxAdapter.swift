import ReactiveSwift
import VueFlux

final class VueFluxAdapter: VueFluxAdapterProtocol {

    struct Dependency {
        /// protocolで型を持ちDI可能にする
        var repository: CountUpRepositoryProtocol
        static func`default`() -> Dependency {
            Dependency(
               repository: CountUpRepository()
            )
        }
    }

    /// Storeを介さないとcomputedとactionにアクセスできない
    /// Storeは状態を管理するもの。共有インスタンスを生成し、状態を管理する
    var dataModel: Property<CountUpDataModel> {
        // hogehoge
        store.computed.dataModel
    }

    /// storeは共有インスタンス。状態管理している
    ///  あるアクションからdispatchされ、指定されたstoreの状態を変異させる
    private let store = Store<VueFluxState>(state: .init(), mutations: .init())
    private let dependency: Dependency
    // TODO: - ScopedSerialDisposableが何をしているか聞く。
    /// ただdispose()の処理を簡単にしていると命名から予想。
    private let refreshDisposable = ScopedSerialDisposable()

    init(dependency: Dependency) {
        self.dependency = dependency
    }

    func refresh() {
        let actions = store.actions
        actions.dispatch(action: .loading)
        refreshDisposable.serial = dependency.repository.refresh()
            .startWithResult { result in
                actions.dispatch(action: .loaded(result))
            }
    }

    func incrementNumber(
        number: Int
    ) {
        let actions = store.actions
        actions.dispatch(action: .loading)
        refreshDisposable.serial = dependency.repository.incrementNumber(number: number)
            .startWithResult { result in
                actions.dispatch(action: .loaded(result))
            }
    }
}
