import HymnbookUI
import SwiftUI
import UIKit

enum SongUIComposer {
    static func make() -> UIViewController {
//        UIHostingController(rootView: StanzaView(stanza:
//            """
//            A beleza da tua santidade é maior
//            Que as maravilhas da Terra
//            Pois aqui cada uma se encerra
//            Tua beleza, porém, por toda eternidade é!
//            """)
//        )
        UIHostingController(rootView: SongView())
    }
}
