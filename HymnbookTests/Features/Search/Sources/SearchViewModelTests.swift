import SwiftUI
import XCTest
enum SearchState {
    case loading
    case error
    case content
}

final class SearchViewModel: ObservableObject {
    @Published var state = SearchState.loading
}

final class SearchViewModelTests: XCTestCase {
    func testInitsOnLoadingState() {
        let sut = SearchViewModel()

        XCTAssertEqual(sut.state, .loading)
    }
}
