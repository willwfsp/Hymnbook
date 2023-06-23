import Combine
import SwiftUI
import UIKit

enum SearchUIComposer {
    static func make(
        onSelect: @escaping (SearchItem) -> Void
    ) -> UIViewController {
        let binder = Binder(
            loader: SearchStubAdapter(),
            viewModel: SearchViewModel(onSelect: onSelect)
        )

        let view = ComposedView(viewModel: binder.viewModel)
            .onAppear {
                binder.fetchSongs()
            }

        let viewController = UIHostingController(rootView: view)
        viewController.title = "Search"

        return viewController
    }
}

extension SearchUIComposer {
    class Binder {
        let viewModel: SearchViewModel
        let loader: SearchLoader

        private var cancellable: AnyCancellable?

        init(
            loader: SearchLoader,
            viewModel: SearchViewModel
        ) {
            self.loader = loader
            self.viewModel = viewModel
        }

        func fetchSongs() {
            cancellable = loader
                .fetchSongsPublisher()
                .dispatchOnMainQueue()
                .sinkResult { [weak self] result in
                    self?.viewModel.result = result
                }
        }
    }
}

extension SearchUIComposer {
    struct ComposedView: View {
        @ObservedObject var viewModel: SearchViewModel

        var body: some View {
            SearchView(
                state: viewModel.state
            )
            .searchable(text: $viewModel.searchText)
        }
    }
}

extension SearchLoader {
    func fetchSongsPublisher() -> AnyPublisher<[SearchItem], Error> {
        Deferred {
            Future {
                try await fetchSongs()
            }
        }
        .eraseToAnyPublisher()
    }
}
