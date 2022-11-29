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
