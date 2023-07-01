import SwiftUI

public enum SearchViewState {
    case content(SearchResultsState)
    case error(title: String, message: String)
    case empty(title: String, message: String)
    case loading
}

public struct SearchView: View {
    private var state: SearchViewState
    private let onAppear: () -> Void

    public init(
        state: SearchViewState,
        onAppear: @escaping () -> Void
    ) {
        self.state = state
        self.onAppear = onAppear
    }

    public var body: some View {
        switch state {
        case let .content(state):
            SearchResultsView(
                state: state
            )
        case let .empty(title, message):
            EmptyStateView(
                title: title,
                message: message
            )
        case let .error(title, message):
            ErrorStateView(
                title: title,
                message: message
            )
        case .loading:
            ProgressView()
                .scaleEffect(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static func item(_ name: String) -> SearchResultsState.Item {
        .init(
            id: UUID(),
            name: name, onSelect: {}
        )
    }

    static var previews: some View {
        SearchView(
            state: .content(.init(
                list: [
                    item("The Day is Drawing Near"),
                    item("O Lord I come before You in this hour of prayer"),
                    item("No longer am I what I was"),
                    item("God is in His temple"),
                    item("Hallelujah! Many voices of Angels")
                ],
                sectionHeader: "A Header"
            ))
        )
        .previewDisplayName("Content")

        SearchView(
            state: .empty(
                title: "No results to show",
                message: "Please check spelling or try different keywords"
            )
        )
        .previewDisplayName("Empty")

        SearchView(
            state: .loading
        )
        .previewDisplayName("Loading")

        SearchView(
            state: .error(title: "Error", message: "error")
        )
        .previewDisplayName("Error")
    }
}

private extension SearchView {
    init(state: SearchViewState) {
        self.init(state: state, onAppear: {})
    }
}
