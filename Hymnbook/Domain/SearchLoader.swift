import HymnbookUI

protocol SearchLoader {
    func fetchSongs() async throws -> [SearchItem]
}
