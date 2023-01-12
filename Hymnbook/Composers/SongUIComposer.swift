import HymnbookUI
import SwiftUI
import UIKit

enum SongUIComposer {
    static func make(songId _: UUID) -> UIViewController {
        UIHostingController(rootView: SongView())
    }
}
