import XCTest

@testable import HymnbookUI

class HymbookUILocalizationTests: XCTestCase {
    func test_search_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Search"
        let bundle = BundleToken.bundle

        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}
