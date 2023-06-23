import SwiftUI

struct ContextMessageView: View {
    let icon: SystemSymbol?
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 16) {
            if let icon {
                Image(systemSymbol: icon)
                    .font(.system(size: 48))
                    .foregroundColor(.secondary)
            }

            VStack(spacing: 8) {
                Text(title)
                    .font(.title3)
                    .bold()

                Text(message)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: 200)
        }
    }
}

struct ContextMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMessageView(
            icon: .magnifyingGlass,
            title: "No Results to show",
            message: "Please check spelling or try different keywords"
        )
    }
}
