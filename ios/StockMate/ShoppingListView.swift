import SwiftUI
import SwiftData

struct ShoppingListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \ShoppingItem.createdAt, order: .reverse) private var items: [ShoppingItem]
    @State private var name=""
    var body: some View { NavigationStack { List {
        Section { HStack { TextField("要買什麼？", text:$name); Button("加入", action:add).disabled(name.trimmingCharacters(in:.whitespaces).isEmpty) } }
        ForEach(items) { item in HStack { Button { item.completed.toggle() } label: { Image(systemName:item.completed ? "checkmark.circle.fill":"circle") }; VStack(alignment:.leading){Text(item.name).strikethrough(item.completed);Text("數量 \(item.quantity)").font(.caption).foregroundStyle(.secondary)} } }.onDelete { $0.map{items[$0]}.forEach(context.delete) }
    }.navigationTitle("StockMate 採買清單") } }
    private func add(){context.insert(ShoppingItem(name:name.trimmingCharacters(in:.whitespaces)));name=""}
}
