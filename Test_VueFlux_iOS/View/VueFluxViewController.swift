import Carbon
import ReactiveCocoa
import ReactiveSwift
import UIKit
import VueFlux

final class VueFluxViewController: UIViewController {
    public struct Dependency {
        public var notification: NotificationCenter

        public init(
            notification: NotificationCenter
        ) {
            self.notification = notification
        }

        public static var `default`: Dependency {
            Dependency(
                notification: NotificationCenter.default
            )
        }
    }

    private lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "VueFlux"
        label.font = UIFont.boldSystemFont(ofSize: 70.0)
        label.textColor = UIColor.white
        return label
    }()

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textColor = UIColor.white
        return label
    }()

    private lazy var incrementButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: UIControl.State())
        button.titleLabel?.font = .boldSystemFont(ofSize: 70)
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.frame.size.width = 100
        button.frame.size.height = 50
        return button
    }()

    private let adapter: VueFluxAdapterProtocol
    private let dependency: Dependency
    private var number: Int

    init(adapter: VueFluxAdapterProtocol, dependency: Dependency, number: Int) {
        self.adapter = adapter
        self.dependency = dependency
        self.number = number
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(centerLabel)
        view.addSubview(numberLabel)
        view.addSubview(incrementButton)
        print("\(numberLabel.reactive.text) dd")

        // Binding
        incrementButton.reactive.tap
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] in
                guard let me = self else { return }
                me.number = Int(me.adapter.dataModel.map { $0.number }.value) ?? 0
                me.adapter.incrementNumber(number: me.number)
            }

        reactive.viewWillAppear
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] in
                guard let me = self else { return }
                me.adapter.refresh()
            }

        numberLabel.reactive.text <~ adapter.dataModel.map { $0.number }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.activate([
            centerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberLabel.topAnchor.constraint(equalTo: centerLabel.bottomAnchor, constant: 10),
            incrementButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            incrementButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            incrementButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
    }
}
