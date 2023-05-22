import Carbon
import ReactiveCocoa
import ReactiveSwift
import UIKit
import VueFlux

final class FluxViewController: UIViewController {

    private lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Flux"
        label.font = UIFont.boldSystemFont(ofSize: 70.0)
        label.textColor = .black
        return label
    }()

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textColor = .black
        label.text = "0"
        return label
    }()

    private lazy var incrementButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: UIControl.State())
        button.titleLabel?.font = .boldSystemFont(ofSize: 70)
        button.setTitleColor(UIColor.black, for: UIControl.State())
        button.frame.size.width = 100
        button.frame.size.height = 50
        return button
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .darkGray
        view.addSubview(centerLabel)
        view.addSubview(numberLabel)
        view.addSubview(incrementButton)
    }

    func incrementNumber(number: Int) -> SignalProducer<Int, SomeError> {
        let count = number + 1
        return SignalProducer<Int, SomeError>(value: 2)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.activate([
            centerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberLabel.topAnchor.constraint(equalTo: centerLabel.bottomAnchor, constant: 10),
            incrementButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            incrementButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            incrementButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
    }
}
