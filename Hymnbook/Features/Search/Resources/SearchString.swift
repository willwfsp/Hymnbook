import Foundation

final class SearchString {
    private init() {}

    static let sectionContent = "sectionContent".localized()
    static let sectionAllSongs = "sectionAllSongs".localized()
    static let noResultsTitle = "noResultsTitle".localized()
    static let noResultsMessage = "noResultsMessage".localized()
    static let errorTitle = "errorTitle".localized()
    static let errorMessage = "errorMessage".localized()
}

private extension String {
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}
