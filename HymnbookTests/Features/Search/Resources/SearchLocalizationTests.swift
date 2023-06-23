import XCTest

@testable import Hymnbook

class SearchLocalizationTests: XCTestCase {
    func test_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "SearchLocalizable"
        let bundle = Bundle(for: SearchString.self)

        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}
