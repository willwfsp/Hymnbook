import Combine

struct RecentSearches {
    let terms: [String]
}

enum SearchState {
    case idle
    case loading
    case empty
    case content(RecentSearches)
}

typealias FetchRecentSearches = () -> AnyPublisher<[String], Never>

final class SearchViewModel: ObservableObject {
    var state = SearchState.idle {
        didSet {
            switch state {
            case .loading, .idle:
                viewState = .loading
            case let .content(recentSearches):
                viewState = .content(recentSearches)
            case .empty:
                viewState = .empty(
                    title: "What are you searching for?",
                    message: "Search for song names, lyrics and categories"
                )
            }
        }
    }

    @Published var viewState: SearchViewState = .loading

    private let fetchRecentSearches: FetchRecentSearches
    private var cancellable: AnyCancellable?

    init(
        fetchRecentSearches: @escaping FetchRecentSearches
    ) {
        self.fetchRecentSearches = fetchRecentSearches
    }

    func onAppear() {
        state = .loading
        cancellable = fetchRecentSearches().sink { [weak self] terms in
            self?.state = terms.isEmpty
                ? .empty
                : .content(RecentSearches(terms: terms))
        }
    }
}
