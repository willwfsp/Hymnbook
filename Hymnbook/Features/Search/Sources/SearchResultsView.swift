import SwiftUI
public struct SearchResultsState {
    let recentSearches: RecentSearches
    let sectionHeader: String
}

struct SearchResultsView: View {
    let state: RecentSearches

    var body: some View {
        List {}
            .listStyle(.inset)
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(state: .init(terms: [
            "The Day is Drawing Near",
            "The Day is Drawing Near",
            "O Lord I come before You in this hour of prayer",
            "No longer am I what I was",
            "God is in His temple",
            "Hallelujah! Many voices of Angels"
        ]))
        .previewDisplayName("Search Results")
    }
}
