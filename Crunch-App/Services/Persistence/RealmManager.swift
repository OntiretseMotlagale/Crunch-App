
import Foundation
import RealmSwift

class RealmProductItem: Object, Identifiable {
    var id = UUID().uuidString
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var price: Int
    @Persisted var descript: String
    
    convenience init(name: String,
                     image: String,
                     price: Int,
                     descript: String) {
        self.init()
        self.name = name
        self.image = image
        self.price = price
        self.descript = descript
    }
}

class RealmManager {
    let realm = try! Realm()
   
    func addItem(realmItem: RealmProductItem) {
        do {
            try realm.write {
                realm.add(realmItem)
            }
        }
        catch {
            print("Unable to add an item")
        }
    }
    func deleteItem(item: RealmProductItem) {
        do {
            try realm.write {
                realm.delete(item)
            }
        }
        catch {
            print("Error deleting an item \(error.localizedDescription)")
        }
    }
    func fetchRealmItems() -> Results<RealmProductItem> {
        return realm.objects(RealmProductItem.self)
    }
}
