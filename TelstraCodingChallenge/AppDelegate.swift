import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: aboutViewController)
        window?.makeKeyAndVisible()
        return true
    }

    private var aboutViewController: AboutViewController {
        let viewController = AboutViewController()
        viewController.presenter = AboutPresenter(display: viewController)
        return viewController
    }
}
