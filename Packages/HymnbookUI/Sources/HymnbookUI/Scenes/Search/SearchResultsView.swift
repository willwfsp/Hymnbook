import SwiftUI
public struct SearchResultsState {
    struct Item: Identifiable {
        let id: UUID
        let name: String
        let onSelect: () -> Void
    }

    let list: [Item]
    let sectionHeader: String
}

struct SearchResultsView: View {
    let state: SearchResultsState

    var body: some View {
        List {
            Section(header: Text(state.sectionHeader)) {
                ForEach(state.list, id: \.id) { item in
                    HStack {
                        Label(item.name, systemImage: SystemSymbol.magnifyingGlass.rawValue)
                            .lineLimit(1)
                            .padding(.vertical, 8)

                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture(perform: item.onSelect)
                }
            }
        }
        .listStyle(.inset)
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static func item(_ name: String) -> SearchResultsState.Item {
        .init(
            id: UUID(),
            name: name, onSelect: {})
    }

    static var previews: some View {
        SearchResultsView(state: .init(
            list: [
                item("The Day is Drawing Near"),
                item("The Day is Drawing Near"),
                item("O Lord I come before You in this hour of prayer"),
                item("No longer am I what I was"),
                item("God is in His temple"),
                item("Hallelujah! Many voices of Angels")
            ],
            sectionHeader: "Search Results"
        ))
        .previewDisplayName("Search Results")
    }
}
