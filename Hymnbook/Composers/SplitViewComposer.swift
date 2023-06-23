import UIKit

enum SplitViewComposer {
    static func make() -> UIViewController {
        let lazySelection = LazySelectVirtualProxy()

        let primaryViewController = SearchUIComposer.make(onSelect: { [lazySelection] item in
            lazySelection.onSelect?(item)
        })

        let searchRouter = SearchRouter(
            source: primaryViewController
        )

        lazySelection.onSelect = { item in
            searchRouter.showSongWith(id: item.id)
        }

        let nav = UINavigationController(rootViewController: primaryViewController)
        nav.navigationBar.prefersLargeTitles = true

        let splitVC = MainFirstSplitViewController()
        splitVC.viewControllers = [nav]

        return splitVC
    }
}
