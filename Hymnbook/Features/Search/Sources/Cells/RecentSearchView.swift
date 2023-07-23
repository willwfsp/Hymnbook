import SwiftUI

struct RecentSearchView: View {
    let term: String

    var body: some View {
        Label(
            term,
            systemImage: SystemSymbol.clockArrowCirclepath.rawValue
        )
        .lineLimit(1)
    }
}

struct RecentSearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecentSearchView(term: "Short Term")
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Short term example")

            RecentSearchView(term: "Long long long long long long term")
                .previewLayout(.fixed(width: 200, height: 40))
                .padding()
                .previewDisplayName("Long term example")
        }
    }
}
