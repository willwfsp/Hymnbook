import SwiftUI

public struct SongView: View {
    public init() { }

    public var body: some View {
        VStack(spacing: 16) {
            Text("448 - The Day is Drawing Near")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 8) {
                Text("Pleading")
                    .font(.body)
                    .foregroundColor(.secondary)
                Text("•")
                    .font(.body)
                    .foregroundColor(.secondary)
                Text("Tone: A")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("Intro: A E/A D E A")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)

            StanzaView(stanza:
                """
                A beleza da tua santidade é maior
                Que as maravilhas da Terra
                Pois aqui cada uma se encerra
                Tua beleza, porém, por toda eternidade é!
                """
            )
            .padding(.top, 32)
            Spacer()
        }
        .padding()

    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView()
    }
}
