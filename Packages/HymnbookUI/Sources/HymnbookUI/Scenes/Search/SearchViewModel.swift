import Combine
import Foundation

public struct SearchItem {
    public let id: UUID
    public let name: String

    public init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

public final class SearchViewModel: ObservableObject {
    private typealias Strings = L10n.Search

    @Published public var searchText = ""
    @Published public var result: Result<[SearchItem], Error>?
    @Published public var state = SearchViewState.loading

    private var cancellables = Set<AnyCancellable>()
    private var onSelect: (SearchItem) -> Void

    public init(onSelect: @escaping (SearchItem) -> Void) {
        self.onSelect = onSelect

        cancellables = [
            $result.dropFirst().sink { [unowned self] result in
                switch result {
                case .none:
                    state = .loading
                case let .success(list):
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

    private var allSongs: [SearchItem] = [] {
        didSet {
            if allSongs.isEmpty {
                state = .empty(
                    title: Strings.noResultsTitle,
                    message: Strings.noResultsMessage
                )
            } else {
                setContent()
            }
        }
    }

    private var searchTerm: String = "" {
        didSet {
            setContent()
        }
    }

    private func setContent() {
        state = .content(.init(
            list: filteredResults.map { item in
                .init(id: item.id, name: item.name, onSelect: { [weak self] in
                    self?.onSelect(item)
                })
            },
            sectionHeader: sectionHeader
        ))
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

    private var filteredResults: [SearchItem] {
        if searchTerm.isEmpty {
            return allSongs
        } else {
            return allSongs.filter { $0.name.contains(searchTerm) }
        }
    }
}
