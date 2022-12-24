@testable import HymnbookUI
import XCTest
import Combine

final class SearchViewModelTests: XCTestCase {
    typealias Strings = Localization.Search
    struct GenericError: Error { }

    func test_updatesStateOnResultChange() {
        let (sut, output) = makeSUT()
        let (domainItems, viewItems) = resultList

        sut.result = .success(domainItems)
        sut.result = nil
        sut.result = .success([])
        sut.result = .failure(GenericError())

        XCTAssertEqual(output.events, [
            .loading,
            .content(.init(
                list: viewItems,
                sectionHeader: Strings.sectionAllSongs
            )),
            .loading,
            .empty(title: Strings.noResultsTitle, message: Strings.noResultsMessage),
            .error(title: Strings.errorTitle, message: Strings.errorMessage)

        ])
    }

    func test_updatesContentOnSearchTextChange() {
        let (sut, output) = makeSUT()
        let (domainItems, viewItems) = resultList
        sut.result = .success(domainItems)

        sut.searchText = "AAA"

        XCTAssertEqual(output.events, [
            .loading,
            .content(.init(
                list: viewItems,
                sectionHeader: Strings.sectionAllSongs
            )),
            .content(.init(
                list: [
                    .init(id: uuid1, name: "1. AAAAA", onSelect: {}),
                    .init(id: uuid3, name: "3. AAABB", onSelect: {})
                ],
                sectionHeader: Strings.sectionContent
            ))
        ])
    }

    func test_setSelected() {
        var selectedItems: [SearchItem] = []
        let sut = SearchViewModel(onSelect: {
            selectedItems.append($0)
        })
        let item = SearchItem(id: uuid1, name: "A")

        sut.result = .success([item])

        if case .content(let state) = sut.state, let viewItem = state.list.first {
            viewItem.onSelect()
        }

        XCTAssertEqual(selectedItems, [item])
    }

    private var uuid1: UUID { UUID(uuidString: "A4DD3384-F0D3-4E41-8666-B74FDB13ECFF")! }
    private var uuid2: UUID { UUID(uuidString: "1F3FC3E9-7F6F-4EF3-8A93-040883E34622")! }
    private var uuid3: UUID { UUID(uuidString: "59DC8E85-CD30-4C49-89A3-4ADFC62522B8")! }

    private var resultList: ([SearchItem], [SearchResultsState.Item]) {
        let domainItems: [SearchItem] = [
            .init(id: uuid1, name: "1. AAAAA"),
            .init(id: uuid2, name: "2. BBBBB"),
            .init(id: uuid3, name: "3. AAABB")
        ]

        let viewItems: [SearchResultsState.Item] = [
            .init(id: uuid1, name: "1. AAAAA", onSelect: {}),
            .init(id: uuid2, name: "2. BBBBB", onSelect: {}),
            .init(id: uuid3, name: "3. AAABB", onSelect: {})
        ]

        return (domainItems, viewItems)
    }

    private func makeSUT() -> (SearchViewModel, OutputSpy) {
        let sut = SearchViewModel(onSelect: { _ in })
        let output = OutputSpy(viewModel: sut)

        return (sut, output)
    }
}

final class OutputSpy {
    private(set) var events: [SearchViewState] = []
    private(set) var selectedItems: [SearchItem] = []

    private var cancellables: [AnyCancellable] = []

    init(viewModel: SearchViewModel) {
        viewModel.$state.sink { [weak self] in
            self?.events.append($0)
        }.store(in: &cancellables)
    }
}

extension SearchViewState: AutoEquatable { }
extension SearchItem: AutoEquatable { }
