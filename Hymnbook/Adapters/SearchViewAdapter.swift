import Combine
import Foundation
import HymnbookUI

class SearchStubAdapter: ObservableObject {
    @Published var result: Result<[SearchItem], Error>?

    private let mocks: [SearchItem] = [
        .init(id: UUID(), name: "The Day is Drawing Near"),
        .init(id: UUID(), name: "O Lord I come before You in this hour of prayer"),
        .init(id: UUID(), name: "No longer am I what I was"),
        .init(id: UUID(), name: "God is in His temple"),
        .init(id: UUID(), name: "Hallelujah! Many voices of Angels")
    ]

    func fetchSongs() {
        result = nil
        self.result = .success(self.mocks)
    }

    struct GenericError: Error {}
}
