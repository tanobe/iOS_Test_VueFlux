import UIKit

final class VueFluxViewController: UIViewController {

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
        label.text = "0"
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

    init() {

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

