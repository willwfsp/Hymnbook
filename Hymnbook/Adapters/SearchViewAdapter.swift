import Combine
import Foundation

class SearchStubAdapter: ObservableObject {
    @Published var result: Result<[String], Error>?

    private let mocks = [
        "The Day is Drawing Near",
        "O Lord I come before You in this hour of prayer",
        "No longer am I what I was",
        "God is in His temple",
        "Hallelujah! Many voices of Angels",
    ]

    func fetchSongs() {
        result = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let random = Bool.random()
            self.result = random ? .success(self.mocks) : .failure(GenericError())
        }
    }

    struct GenericError: Error {}
}
