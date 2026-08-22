import { randomUUID } from "node:crypto";

export type Item = { id: string; userId: string; name: string; quantity: number; storeId?: string; completed: boolean; createdAt: string };
export class ItemStore {
  private items = new Map<string, Item>();
  list(userId: string) { return [...this.items.values()].filter(i => i.userId === userId); }
  add(input: Omit<Item, "id" | "completed" | "createdAt">) {
    const item: Item = { ...input, id: randomUUID(), completed: false, createdAt: new Date().toISOString() };
    this.items.set(item.id, item); return item;
  }
  remove(userId: string, id: string) { const i=this.items.get(id); return !!i && i.userId===userId && this.items.delete(id); }
  completeByReceipt(userId: string, purchasedNames: string[]) {
    const normalized = purchasedNames.map(normalize);
    return this.list(userId).filter(i => !i.completed && normalized.includes(normalize(i.name))).map(i => { i.completed=true; return i; });
  }
}
export const normalize = (value: string) => value.trim().toLocaleLowerCase("zh-TW").replace(/[\s\-_]/g, "");
