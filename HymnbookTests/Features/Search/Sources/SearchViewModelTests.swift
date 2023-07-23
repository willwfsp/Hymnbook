import Combine
import Foundation
import SwiftUI
import XCTest

@testable import Hymnbook

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
        let expectedTerms = ["A", "B", "C"]

        sut.onAppear()
        recentSearchesFetcher.complete(with: expectedTerms)

        XCTAssertEqual(
            sut.state,
            .content(RecentSearches(terms: expectedTerms))
        )
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
