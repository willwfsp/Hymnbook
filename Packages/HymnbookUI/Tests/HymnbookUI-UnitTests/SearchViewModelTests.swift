@testable import HymnbookUI
import XCTest
import Combine

final class SearchViewModelTests: XCTestCase {
    typealias Strings = Localization.Search
    struct GenericError: Error { }

    func test_updatesStateOnResultChange() {
        let (sut, output) = makeSUT()

        sut.result = .success(resultList)
        sut.result = nil
        sut.result = .success([])
        sut.result = .failure(GenericError())

        XCTAssertEqual(output.events, [
            .loading,
            .content(.init(
                list: resultList,
                sectionHeader: Strings.sectionAllSongs,
                showSuggestions: true
            )),
            .loading,
            .empty(title: Strings.noResultsTitle, message: Strings.noResultsMessage),
            .error(title: Strings.errorTitle, message: Strings.errorMessage)

        ])
    }

    func test_updatesContentOnSearchTextChange() {
        let (sut, output) = makeSUT()
        sut.result = .success(resultList)

        sut.searchText = "AAA"

        XCTAssertEqual(output.events, [
            .loading,
            .content(.init(
                list: resultList,
                sectionHeader: Strings.sectionAllSongs,
                showSuggestions: true
            )),
            .content(.init(
                list: [
                    "1. AAAAA"
                ],
                sectionHeader: Strings.sectionContent,
                showSuggestions: false
            ))
        ])
    }

    private var resultList: [String] {
        [
            "1. AAAAA",
            "2. BBBBB",
            "3. ABABA"
        ]
    }

    private func makeSUT() -> (SearchViewModel, OutputSpy) {
        let sut = SearchViewModel()
        let output = OutputSpy(viewModel: sut)

        return (sut, output)
    }
}

final class OutputSpy {
    private(set) var events: [SearchViewState] = []

    private var cancellables: [AnyCancellable] = []

    init(viewModel: SearchViewModel) {
        viewModel.$state.sink { [weak self] in
            self?.events.append($0)
        }.store(in: &cancellables)
    }
}
