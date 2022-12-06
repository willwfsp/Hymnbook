import Combine

public final class SearchViewModel: ObservableObject {
    private typealias Strings = Localization.Search

    private var cancellables = Set<AnyCancellable>()

    @Published public var searchText = ""
    @Published public var result: Result<[String], Error>?
    @Published public var state = SearchViewState.loading

    public init() {
        cancellables = [
            $result.dropFirst().sink { [unowned self] result in
                switch result {
                case .none:
                    state = .loading
                case .success(let list):
                    allSongs = list
                case .failure:
                    state = .error(
                        title: Strings.errorTitle,
                        message: Strings.errorMessage
                    )
                }
            },

            $searchText
                .dropFirst()
                .assign(to: \.searchTerm, on: self)
        ]
    }

    private var allSongs: [String] = [] {
        didSet {
            if allSongs.isEmpty {
                state = .empty(
                    title: Strings.noResultsTitle,
                    message: Strings.noResultsMessage
                )
            } else {
                state = .content(.init(
                    list: filteredResults,
                    sectionHeader: sectionHeader,
                    showSuggestions: showSuggestions
                ))
            }
        }
    }

    private var searchTerm: String = "" {
        didSet {
            state = .content(.init(
                list: filteredResults,
                sectionHeader: sectionHeader,
                showSuggestions: showSuggestions
            ))
        }
    }

    private var sectionHeader: String {
        if searchTerm.isEmpty {
            return Strings.sectionAllSongs
        }

        if case .content = state {
            return Strings.sectionContent
        }

        return ""
    }

    private var showSuggestions: Bool {
        searchTerm.isEmpty
    }

    private var filteredResults: [String] {
        if searchTerm.isEmpty {
            return allSongs
        } else {
            return allSongs.filter { $0.contains(searchTerm) }
        }
    }
}
