import SwiftUI
import SwiftData

@main struct StockMateApp: App {
    var body: some Scene { WindowGroup { ShoppingListView() }.modelContainer(for: ShoppingItem.self) }
}
