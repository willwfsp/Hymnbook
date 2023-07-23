import Combine
import SwiftUI
import UIKit

enum SplitViewComposer {
    static func make() -> UIViewController {
        let viewModel = SearchViewModel {
            Just(["My portion", "How can I keep How can I keep How can I keep How can I keep"])
                .delay(for: .seconds(2), scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        }

        let primaryViewController = UIHostingController(rootView: SearchViewAdapter(viewModel: viewModel))

        let nav = UINavigationController(rootViewController: primaryViewController)
        nav.navigationBar.prefersLargeTitles = true

        let splitVC = MainFirstSplitViewController()
        splitVC.viewControllers = [nav]

        return splitVC
    }
}

struct SearchViewAdapter: View {
    @ObservedObject var viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        viewModel.$viewState.subscribe(Subscribers.Sink(receiveCompletion: { _ in }, receiveValue: { result in
            print(result)
        }))
    }

    var body: some View {
        SearchView(state: $viewModel.viewState)
            .onAppear(perform: viewModel.onAppear)
    }
}
