import Carbon
import ReactiveCocoa
import ReactiveSwift
import UIKit
import VueFlux

final class TextFieldViewController: UIViewController {
    private lazy var textField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.frame = CGRect(x: 10, y: 100, width: UIScreen.main.bounds.size.width-20, height: 38)
        // プレースホルダを設定
        textField.placeholder = "入力してください。"
        textField.keyboardType = .default
        textField.borderStyle = .roundedRect
        return textField
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textField)
        view.addSubview(incrementButton)

        // binding
        let observer = Signal<Bool, Never>.Observer(value: { value in
            print("Observerの動きをみる")
            print(value)
            print("Observerの動きをみる")
            self.incrementButton.isEnabled = value
        })
        let signal = textField.reactive.continuousTextValues
        signal
            .map { text in
                print("mapの動きをみる")
                print(text)
                print("mapの動きをみる")
                return !(text.count > 10)
            }

        signal
            .map { text in
                print("mapの動きをみる")
                print(text)
                print("mapの動きをみる")
                return !(text.count > 10)
            }
            .observeValues { value in
                self.incrementButton.isEnabled = value
            }
        incrementButton.reactive.tap
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] in
                print("タップ可能")
            }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            incrementButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            incrementButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30)
        ])
    }
}
