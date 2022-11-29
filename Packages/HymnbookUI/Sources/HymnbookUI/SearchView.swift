import SwiftUI

public struct SearchView: View {
    @State private var results: [String]
    @State private var searchText = ""

    public init(results: [String]) {
        self.results = results
    }

    private var sectionHeader: String {
        if searchText.isEmpty {
            return "All Praise Songs"
        }

        if searchResults.isEmpty {
            return ""
        }

        return "Search Results"
    }

    public var body: some View {
        SearchResultsView(
            results: searchResults,
            sectionHeader: sectionHeader,
            showSuggestions: searchText.isEmpty
        )
        .searchable(text: $searchText)
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return results
        } else {
            return results.filter { $0.contains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(results:  [
            "The Day is Drawing Near",
            "O Lord I come before You in this hour of prayer",
            "No longer am I what I was",
            "God is in His temple",
            "Hallelujah! Many voices of Angels",
        ])
    }
}
