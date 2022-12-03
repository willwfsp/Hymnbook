import SwiftUI
public struct SearchResultsState: Equatable {
    let list: [String]
    let sectionHeader: String
    let showSuggestions: Bool
}

struct SearchResultsView: View {
    let state: SearchResultsState

    var body: some View {
        List {
            Section(header: Text(state.sectionHeader)) {
                ForEach(state.list, id: \.self) { name in
                    HStack {
                        if !state.showSuggestions {
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
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(state: .init(
            list:  [
                "The Day is Drawing Near",
                "O Lord I come before You in this hour of prayer",
                "No longer am I what I was",
                "God is in His temple",
                "Hallelujah! Many voices of Angels",
            ],
            sectionHeader: "All songs",
            showSuggestions: true
        ))
        .previewDisplayName("Suggestions")

        SearchResultsView(state: .init(
            list:  [
                "The Day is Drawing Near",
                "O Lord I come before You in this hour of prayer",
                "No longer am I what I was",
                "God is in His temple",
                "Hallelujah! Many voices of Angels",
            ],
            sectionHeader: "Search Results",
            showSuggestions: false
        ))
        .previewDisplayName("Search Results")
    }
}
