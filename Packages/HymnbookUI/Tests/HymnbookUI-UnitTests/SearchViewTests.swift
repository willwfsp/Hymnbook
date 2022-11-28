import HymnbookUI
import SwiftUI
import XCTest

final class SearchViewTests: XCTestCase {
    func test_initialState() throws {
        let sut = SearchView(results:  [
            "The Day is Drawing Near",
            "O Lord I come before You in this hour of prayer",
            "No longer am I what I was",
            "God is in His temple",
            "Hallelujah! Many voices of Angels",
        ])

        assertSnapshot(screen: sut)
    }
}
