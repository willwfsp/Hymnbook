import SwiftUI

public struct StanzaView: View {
    public init(stanza: String) {
        self.stanza = stanza
    }

    private let stanza: String

    public var body: some View {
        VStack {
            Text(stanza)
                .font(.system(size: 18, design: .monospaced))
                .lineSpacing(8)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .multilineTextAlignment(.leading)

    }
}

struct StanzaView_Previews: PreviewProvider {
    static var previews: some View {
        StanzaView(stanza:
            """
            A beleza da tua santidade é maior
            Que as maravilhas da Terra
            Pois aqui cada uma se encerra
            Tua beleza, porém, por toda eternidade é!
            """
        )
    }
}
