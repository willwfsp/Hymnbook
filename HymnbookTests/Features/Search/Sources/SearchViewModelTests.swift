import Combine
import Foundation
import SwiftUI
import XCTest

enum SearchState {
    case idle
    case loading
    case empty
}

typealias FetchRecentSearches = () -> AnyPublisher<[String], Never>

final class SearchViewModel: ObservableObject {
    @Published var state = SearchState.idle

    private let fetchRecentSearches: FetchRecentSearches

    init(
        fetchRecentSearches: @escaping FetchRecentSearches
    ) {
        self.fetchRecentSearches = fetchRecentSearches
    }

    func onAppear() {
        state = .loading
        fetchRecentSearches().sink { _ in
            self.state = .empty
        }
    }
}

final class SearchViewModelTests: XCTestCase {
    func test_initsIdling() {
        let (_, spy) = makeSUT()

        XCTAssertTrue(spy.events.isEmpty)
    }

    func test_awaysFetchRecentSearchesOnAppear() {
        let (sut, spy) = makeSUT()

        sut.onAppear()
        sut.onAppear()

        XCTAssertEqual(spy.events, [
            .fetchRecentSearches,
            .fetchRecentSearches
        ])
    }

    private func makeSUT() -> (
        SearchViewModel,
        SearchViewModelDependenciesSpy
    ) {
        let spy = SearchViewModelDependenciesSpy()
        let sut = SearchViewModel(fetchRecentSearches: spy.fetchRecentSearches)

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
