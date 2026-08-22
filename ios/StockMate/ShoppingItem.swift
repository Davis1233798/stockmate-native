import Foundation
import SwiftData

@Model final class ShoppingItem {
    var id: UUID; var name: String; var quantity: Int; var storeID: String?; var completed: Bool; var createdAt: Date
    init(name: String, quantity: Int = 1, storeID: String? = nil) { self.id=UUID(); self.name=name; self.quantity=quantity; self.storeID=storeID; self.completed=false; self.createdAt=Date() }
}
