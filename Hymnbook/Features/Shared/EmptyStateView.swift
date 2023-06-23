import SwiftUI

struct EmptyStateView: View {
    let title: String
    let message: String

    var body: some View {
        ContextMessageView(
            icon: .magnifyingGlass,
            title: title,
            message: message
        )
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(
            title: "No Results to show",
            message: "Please check spelling or try different keywords"
        )
    }
}
