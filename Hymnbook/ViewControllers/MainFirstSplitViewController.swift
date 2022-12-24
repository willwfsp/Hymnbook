import UIKit

final class MainFirstSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        preferredDisplayMode = .oneBesideSecondary
    }

    func splitViewController(
        _: UISplitViewController,
        collapseSecondary _: UIViewController,
        onto _: UIViewController
    ) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        true
    }
}
