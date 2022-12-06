import SwiftUI

public struct StanzaView: View {
    public init(stanza: String) {
        self.stanza = stanza
    }

    private let stanza: String

    public var body: some View {
        VStack {
            Text(stanza)
                .font(.body.monospaced())
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineSpacing(8)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(.leading)

    }
}

struct LyricsView_Previews: PreviewProvider {
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

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
