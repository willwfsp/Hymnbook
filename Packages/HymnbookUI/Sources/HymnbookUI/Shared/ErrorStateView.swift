import SwiftUI

struct ErrorStateView: View {
    let title: String
    let message: String

    var body: some View {
        ContextMessageView(
            icon: .xCircleFill,
            title: title,
            message: message
        )
    }
}

struct ErrorStateView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorStateView(
            title: "Ops!",
            message: "Something went wrong. Please try again."
        )
    }
}
