import UIKit

@objc(TestAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TestingViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

private final class TestingViewController: UIViewController {

    private var testLabel: UILabel = {
        let label = UILabel()
        label.text = "🍳"
        label.font = .systemFont(ofSize: 100)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(testLabel)
        testLabel.centerInSuperview(size: CGSize(width: view.frame.width, height: view.frame.height))
    }
}
