import SwiftUI

struct SearchResultsView: View {
    let results: [String]
    let sectionHeader: String
    let showSuggestions: Bool

    private var contentStateView: some View {
        List {
            Section(header: Text(sectionHeader)) {
                ForEach(results, id: \.self) { name in
                    HStack {
                        if !showSuggestions {
                            Image(.magnifyingGlass)
                        }
                        Text(name)
                            .lineLimit(1)
                            .padding(.vertical, 8)
                    }
                }
            }
        }
        .listStyle(.inset)
    }

    var body: some View {
        if results.isEmpty {
            EmptyStateView(
                title: "No results to show",
                message: "Please check spelling or try different keywords"
            )
        } else {
            contentStateView
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(
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

        SearchResultsView(
            results:  [
                "The Day is Drawing Near",
                "O Lord I come before You in this hour of prayer",
                "No longer am I what I was",
                "God is in His temple",
                "Hallelujah! Many voices of Angels",
            ],
            sectionHeader: "Search Results",
            showSuggestions: false
        )

        SearchResultsView(
            results:  [],
            sectionHeader: "All songs",
            showSuggestions: true
        )
    }
}
