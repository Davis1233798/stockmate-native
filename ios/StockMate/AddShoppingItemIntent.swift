import AppIntents
import SwiftData

struct AddShoppingItemIntent: AppIntent {
    static var title: LocalizedStringResource="新增採買項目"
    @Parameter(title:"品項") var name:String
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let container = try ModelContainer(for: ShoppingItem.self)
        container.mainContext.insert(ShoppingItem(name:name))
        try container.mainContext.save()
        return .result(dialog:"已將\(name)加入採買清單")
    }
}
