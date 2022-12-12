import Combine
import HymnbookUI
import SwiftUI
import UIKit

private class SearchBinder {
    let viewModel: SearchViewModel
    let adapter = SearchStubAdapter()

    var cancellables: Set<AnyCancellable> = []

    init(onSelect: @escaping (SearchItem) -> Void) {
        viewModel = SearchViewModel(onSelect: onSelect)

        adapter.$result
            .sink { [unowned self] in
                self.viewModel.result = $0
            }.store(in: &cancellables)
    }
}

enum SearchComposer {
    struct SearchComposedView: View {
        @ObservedObject var viewModel: SearchViewModel

        var body: some View {
            SearchView(
                searchText: $viewModel.searchText,
                state: $viewModel.state
            )
        }
    }

    static func make(onSelect: @escaping (SearchItem) -> Void) -> UIViewController {
        let binder = SearchBinder(onSelect: onSelect)

        let view = SearchComposedView(viewModel: binder.viewModel)
            .onAppear {
                binder.adapter.fetchSongs()
            }

        let viewController = UIHostingController(rootView: view)
        viewController.title = "Search"

        return viewController
    }
}
