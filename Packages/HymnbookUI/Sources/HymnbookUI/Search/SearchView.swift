import SwiftUI

public enum SearchViewState: Equatable {
    case content(SearchResultsState)
    case error(title: String, message: String)
    case empty(title: String, message: String)
    case loading
}

public struct SearchView: View {
    @Binding private var searchText: String
    @Binding private var state: SearchViewState

    public init(searchText: Binding<String>, state: Binding<SearchViewState>) {
        _searchText = searchText
        _state = state
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
        }.searchable(text: $searchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(
            searchText: .constant("Some"),
            state:  .constant(.content(.init(
                list: [
                    "The Day is Drawing Near",
                    "O Lord I come before You in this hour of prayer",
                    "No longer am I what I was",
                    "God is in His temple",
                    "Hallelujah! Many voices of Angels"
                ],
                sectionHeader: "A Header",
                showSuggestions: false
            )))
        )
        .previewDisplayName("Content")

        SearchView(
            searchText: .constant("Any"),
            state:  .constant(.empty(
                title: "No results to show",
                message: "Please check spelling or try different keywords"
            ))
        )
        .previewDisplayName("Empty")

        SearchView(
            searchText: .constant(""),
            state: .constant(.loading)
        )
        .previewDisplayName("Loading")

        SearchView(
            searchText: .constant(""),
            state: .constant(.error(title: "Error", message: "error"))
        )
        .previewDisplayName("Error")
    }
}
