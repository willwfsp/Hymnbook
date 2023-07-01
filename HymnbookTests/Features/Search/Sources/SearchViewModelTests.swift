import Combine
import Foundation
import SwiftUI
import XCTest

enum SearchState {
    case idle
    case loading
    case empty
}

final class SearchViewModel: ObservableObject {
    @Published var state = SearchState.idle

    private let fetchRecentSearches: () async -> [String]

    init(
        fetchRecentSearches: @escaping () async -> [String]
    ) {
        self.fetchRecentSearches = fetchRecentSearches
    }

    func onAppear() async {
        state = .loading
        _ = await fetchRecentSearches()
        state = .empty
    }
}

final class SearchViewModelTests: XCTestCase {
    func test_initsIdling() {
        let (_, spy) = makeSUT()

        XCTAssertEqual(spy.events, [
            .state(.idle)
        ])
    }

    func test_fetchesNoRecentSearchOnAppear() async {
        let (sut, spy) = makeSUT(expectedRecentSearches: [])

        await sut.onAppear()

        XCTAssertEqual(spy.events, [
            .state(.idle),
            .state(.loading),
            .fetchRecentSearches,
            .state(.empty)
        ])
    }

    func test_awaysLoadOnAppear() async {
        let (sut, spy) = makeSUT(expectedRecentSearches: [])

        await sut.onAppear()
        await sut.onAppear()

        XCTAssertEqual(spy.events, [
            .state(.idle),
            .state(.loading),
            .fetchRecentSearches,
            .state(.empty),

            .state(.loading),
            .fetchRecentSearches,
            .state(.empty)
        ])
    }

    private func makeSUT(
        expectedRecentSearches _: [String] = []
    ) -> (
        SearchViewModel,
        SearchViewModelDependenciesSpy
    ) {
        let spy = SearchViewModelDependenciesSpy(recentSearches: [])
        let sut = SearchViewModel(fetchRecentSearches: spy.fetchRecentSearches)

        spy.bind(viewModel: sut)

        return (sut, spy)
    }
}

extension SearchState: AutoEquatable {}

final class SearchViewModelDependenciesSpy {
    enum Event: Equatable {
        case fetchRecentSearches
        case state(SearchState)
    }

    private(set) var events = [Event]()
    private var cancellables = [AnyCancellable]()

    private let recentSearches: [String]

    init(recentSearches: [String]) {
        self.recentSearches = recentSearches
    }

    func bind(viewModel: SearchViewModel) {
        viewModel.$state.sink { state in
            self.events.append(.state(state))
        }.store(in: &cancellables)
    }

    func fetchRecentSearches() async -> [String] {
        events.append(.fetchRecentSearches)

        return recentSearches
    }
}
