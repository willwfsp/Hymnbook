import SwiftUI
import UIKit
import HymnbookUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let lazySelection = LazySelectVirtualProxy()

        let primaryViewController = SearchComposer.make(onSelect: { [lazySelection] item in
            lazySelection.onSelect?(item)
        })

        let secondaryViewController = SongUIComposer.make()

        lazySelection.onSelect = { _ in
            let nav = MultilineTitleNavigationController(rootViewController: secondaryViewController)
            secondaryViewController.navigationItem.largeTitleDisplayMode = .never
            secondaryViewController.title = "Song"
            primaryViewController.showDetailViewController(nav, sender: nil)
        }

        let nav = UINavigationController(rootViewController: primaryViewController)
        nav.navigationBar.prefersLargeTitles = true

        let splitVC = MainFirstSplitViewController()
        splitVC.viewControllers = [nav]

        window.rootViewController = splitVC

        self.window = window
        window.makeKeyAndVisible()
    }
}

class LazySelectVirtualProxy {
    var onSelect: ((SearchItem) -> Void)?
}

class MultilineTitleNavigationController: UINavigationController, UINavigationBarDelegate {
    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        item.setValue(true, forKey: "__largeTitleTwoLineMode")
        return true
    }
}

extension UINavigationBar {
    func setMultiline(title: String) {
        for navItem in subviews {
             for itemSubView in navItem.subviews {
                 if let largeLabel = itemSubView as? UILabel {
                     largeLabel.text = title
                     largeLabel.numberOfLines = 0
                     largeLabel.lineBreakMode = .byWordWrapping
                 }
             }
        }
    }
}
