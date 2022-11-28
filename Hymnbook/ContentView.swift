import HymnbookUI
import SwiftUI

struct ContentView: View {
    var body: some View {
        SearchView(results:  [
            "The Day is Drawing Near",
            "O Lord I come before You in this hour of prayer",
            "No longer am I what I was",
            "God is in His temple",
            "Hallelujah! Many voices of Angels",
        ])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
