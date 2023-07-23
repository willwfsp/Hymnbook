import SwiftUI

enum SystemSymbol: String {
    case magnifyingGlass = "magnifyingglass"
    case xCircleFill = "x.circle.fill"
    case clockArrowCirclepath = "clock.arrow.circlepath"
}

extension Image {
    init(systemSymbol: SystemSymbol) {
        self.init(systemName: systemSymbol.rawValue)
    }
}
