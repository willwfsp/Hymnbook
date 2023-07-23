import SwiftUI

enum SearchViewState {
    case content(RecentSearches)
    case error(title: String, message: String)
    case empty(title: String, message: String)
    case loading
}

struct SearchView: View {
    @Binding private var state: SearchViewState
    @State private var searchText: String = ""

    init(state: Binding<SearchViewState>) {
        _state = state
    }

    var body: some View {
        switch state {
        case let .content(state):
            SearchResultsView(
                state: state
            )
            .searchable(text: $searchText, prompt: "Looking for something?")
            .searchSuggestions {
                ForEach(state.terms, id: \.self) { term in
                    RecentSearchView(term: term)
                        .searchCompletion(term)
                }
            }
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
