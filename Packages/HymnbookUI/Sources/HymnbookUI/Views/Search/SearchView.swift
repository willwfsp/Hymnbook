import SwiftUI

public enum SearchViewState {
    case content(SearchResultsState)
    case error(title: String, message: String)
    case empty(title: String, message: String)
    case loading
}

public struct SearchView: View {
    private var state: SearchViewState

    public init(state: SearchViewState) {
        self.state = state
    }

    public var body: some View {
        Group {
            switch state {
            case .content(let state):
                SearchResultsView(
                    state: state
                )
            case .empty(let title, let message):
                EmptyStateView(
                    title: title,
                    message: message
                )
            case .error(let title, let message):
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
}

struct ContentView_Previews: PreviewProvider {
    static func item(_ name: String) -> SearchResultsState.Item {
        .init(
            id: UUID(),
            name: name, onSelect: {})
    }

    static var previews: some View {
        SearchView(
            state:  .content(.init(
                list: [
                    item("The Day is Drawing Near"),
                    item("O Lord I come before You in this hour of prayer"),
                    item("No longer am I what I was"),
                    item("God is in His temple"),
                    item("Hallelujah! Many voices of Angels"),
                ],
                sectionHeader: "A Header"
            ))
        )
        .previewDisplayName("Content")

        SearchView(
            state:  .empty(
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
