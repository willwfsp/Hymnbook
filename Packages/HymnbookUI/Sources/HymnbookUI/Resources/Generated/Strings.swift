// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Search {
    /// Something went wrong. Please try again.
    internal static let errorMessage = L10n.tr("Search", "search.errorMessage", fallback: "Something went wrong. Please try again.")
    /// Ops!
    internal static let errorTitle = L10n.tr("Search", "search.errorTitle", fallback: "Ops!")
    /// Please check spelling or try different keywords
    internal static let noResultsMessage = L10n.tr("Search", "search.noResultsMessage", fallback: "Please check spelling or try different keywords")
    /// No results to show
    internal static let noResultsTitle = L10n.tr("Search", "search.noResultsTitle", fallback: "No results to show")
    /// All Praise Songs
    internal static let sectionAllSongs = L10n.tr("Search", "search.sectionAllSongs", fallback: "All Praise Songs")
    /// Search Results
    internal static let sectionContent = L10n.tr("Search", "search.sectionContent", fallback: "Search Results")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

