import SwiftUI

enum Icon: String {
    case magnifyingGlass = "magnifyingglass"
    case xCircleFill = "x.circle.fill"
}

extension Image {
    init(_ icon: Icon) {
        self.init(systemName: icon.rawValue)
    }
}
