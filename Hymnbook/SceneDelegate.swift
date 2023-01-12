import HymnbookUI
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let splitVC = SplitViewComposer.make()

        window.rootViewController = splitVC

        self.window = window
        window.makeKeyAndVisible()
    }
}

class LazySelectVirtualProxy {
    var onSelect: ((SearchItem) -> Void)?
}

class SearchRouter {
    private let source: UIViewController
    private let makeSongScreen: (UUID) -> UIViewController

    init(source: UIViewController, makeSongScreen: @escaping (UUID) -> UIViewController) {
        self.source = source
        self.makeSongScreen = makeSongScreen
    }

    func showSongWith(id: UUID) {
        let secondaryViewController = makeSongScreen(id)

        let nav = UINavigationController(rootViewController: secondaryViewController)
        secondaryViewController.navigationItem.largeTitleDisplayMode = .never
        secondaryViewController.title = "Song"
        source.showDetailViewController(nav, sender: nil)
    }
}
