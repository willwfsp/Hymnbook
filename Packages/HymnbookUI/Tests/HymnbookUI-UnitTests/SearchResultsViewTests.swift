import SwiftUI
import XCTest

@testable import HymnbookUI

final class SearchResultsViewTests: XCTestCase {
    func test_emptyState() throws {
        let sut = SearchResultsView(
            results: [],
            sectionHeader: .anyValue,
            showSuggestions: .anyValue
        )

        assertSnapshot(screen: sut)
    }

    func test_initsShowingSuggestions() throws {
        let sut = SearchResultsView(
            results:  [
                "The Day is Drawing Near",
                "O Lord I come before You in this hour of prayer",
                "No longer am I what I was",
                "God is in His temple",
                "Hallelujah! Many voices of Angels",
            ],
            sectionHeader: "All songs",
            showSuggestions: true
        )

        assertSnapshot(screen: sut)
    }
}

extension String {
    static var anyValue: String {
        UUID().uuidString
    }
}

extension Bool {
    static var anyValue: Bool {
        .random()
    }
}
