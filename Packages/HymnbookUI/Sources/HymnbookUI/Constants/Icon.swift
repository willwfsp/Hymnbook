import SwiftUI

enum Icon: String {
    case magnifyingGlass = "magnifyingglass"
}

extension Image {
    init(_ icon: Icon) {
        self.init(systemName: icon.rawValue)
    }
}
