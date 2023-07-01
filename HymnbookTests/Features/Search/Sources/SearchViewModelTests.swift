import Combine
import Foundation
import SwiftUI
import XCTest

enum SearchState {
    case idle
    case loading
    case empty
    case content([String])
}

typealias FetchRecentSearches = () -> AnyPublisher<[String], Never>

final class SearchViewModel: ObservableObject {
    @Published var state = SearchState.idle

    private let fetchRecentSearches: FetchRecentSearches
    private var cancellable: AnyCancellable?

    init(
        fetchRecentSearches: @escaping FetchRecentSearches
    ) {
        self.fetchRecentSearches = fetchRecentSearches
    }

    func onAppear() {
        state = .loading
        cancellable = fetchRecentSearches().sink { [weak self] result in
            self?.state = result.isEmpty ? .empty : .content(result)
        }
    }
}

final class SearchViewModelTests: XCTestCase {
    func test_initsIdling() {
        let (sut, recentSearchesFetcher) = makeSUT()

        XCTAssertTrue(recentSearchesFetcher.events.isEmpty)
        XCTAssertEqual(sut.state, .idle)
    }

    func test_awaysFetchRecentSearchesOnAppear() {
        let (sut, recentSearchesFetcher) = makeSUT()

        sut.onAppear()
        XCTAssertEqual(sut.state, .loading)
        sut.onAppear()

        XCTAssertEqual(sut.state, .loading)
        XCTAssertEqual(recentSearchesFetcher.events, [
            .fetchRecentSearches,
            .fetchRecentSearches
        ])
    }

    func test_setsEmptyStateUponNoRecentSearchesFetched() {
        let (sut, recentSearchesFetcher) = makeSUT()

        sut.onAppear()
        recentSearchesFetcher.complete(with: [])

        XCTAssertEqual(sut.state, .empty)
        XCTAssertEqual(recentSearchesFetcher.events, [
            .fetchRecentSearches
        ])
    }

    func test_deliversContentWhenThereAreRecentSearches() {
        let (sut, recentSearchesFetcher) = makeSUT()

        sut.onAppear()
        recentSearchesFetcher.complete(with: ["A", "B", "C"])

        XCTAssertEqual(sut.state, .content(["A", "B", "C"]))
        XCTAssertEqual(recentSearchesFetcher.events, [
            .fetchRecentSearches
        ])
    }

    private func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (
        SearchViewModel,
        SearchViewModelDependenciesSpy
    ) {
        let spy = SearchViewModelDependenciesSpy()
        let sut = SearchViewModel(fetchRecentSearches: spy.fetchRecentSearches)

        trackForMemoryLeaks(sut, spy, file: file, line: line)
        return (sut, spy)
    }
}

extension SearchState: AutoEquatable {}

final class SearchViewModelDependenciesSpy {
    enum Event: Equatable {
        case fetchRecentSearches
    }

    private(set) var events = [Event]()
    private var promises = [(Result<[String], Never>) -> Void]()

    func fetchRecentSearches() -> AnyPublisher<[String], Never> {
        events.append(.fetchRecentSearches)

        return Deferred {
            Future { promise in
                self.promises.append(promise)
            }
        }.eraseToAnyPublisher()
    }

    func complete(with recentSearches: [String], at index: Int = 0) {
        promises[index](.success(recentSearches))
    }
}
