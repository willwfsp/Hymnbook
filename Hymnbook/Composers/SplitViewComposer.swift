import SwiftUI
import UIKit

enum SplitViewComposer {
    static func make() -> UIViewController {
        let primaryViewController = UIHostingController(rootView: SearchView(state: .loading))

        let nav = UINavigationController(rootViewController: primaryViewController)
        nav.navigationBar.prefersLargeTitles = true

        let splitVC = MainFirstSplitViewController()
        splitVC.viewControllers = [nav]

        return splitVC
    }
}
