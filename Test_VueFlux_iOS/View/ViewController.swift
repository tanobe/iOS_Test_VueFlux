import UIKit
import ReactiveSwift

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
    }

    func setupTab() {
        let adapter = VueFluxAdapter(dependency: .default())
        let firstViewController = VueFluxViewController(adapter: adapter, dependency: .default, number: 0)
        firstViewController.tabBarItem = UITabBarItem(title: "VueFlux", image: .none, tag: 0)

        let secondViewController = FluxViewController(number: 0)
        secondViewController.tabBarItem = UITabBarItem(title: "Flux", image: .none, tag: 0)

        let thirdViewController = TextFieldViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Test", image: .none, tag: 0)


        viewControllers = [firstViewController, secondViewController, thirdViewController]
    }
}
