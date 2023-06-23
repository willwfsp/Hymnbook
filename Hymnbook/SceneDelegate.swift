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

class SearchRouter {
    private let source: UIViewController

    init(source: UIViewController) {
        self.source = source
    }

    func showSongWith(id _: UUID) {}
}
