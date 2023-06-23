import XCTest

final class SearchViewModel {
    var isLoading = false
    let hasError = false
    let content = [String]()

    func onAppear() {
        isLoading = true
    }
}

final class SearchViewModelTests: XCTestCase {
    func testInitsOnBlankState() {
        let sut = SearchViewModel()

        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.hasError)
        XCTAssertTrue(sut.content.isEmpty)
    }

    func testStartsLoadingOnAppear() {
        let sut = SearchViewModel()

        sut.onAppear()

        XCTAssertTrue(sut.isLoading)
        XCTAssertFalse(sut.hasError)
        XCTAssertTrue(sut.content.isEmpty)
    }
}
