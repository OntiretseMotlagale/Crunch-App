
import Foundation
import RealmSwift

class RealmDatabaseOrders :Object, Identifiable {
    @Persisted var itemName: String
    @Persisted var itemImage: String
    @Persisted var itemPrice: Int
    
    convenience init(itemName: String,  itemImage: String, itemPrice: Int) {
        self.init()
        self.itemName = itemName
        self.itemImage = itemImage
        self.itemPrice = itemPrice
    }
}
class RealmDatabaseUser: Object, Identifiable {
    @Persisted var fullname: String
    @Persisted var email: String
    
    convenience init(fullname: String, email: String) {
        self.init()
        self.email = email
        self.fullname = fullname
    }
}
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
    func deleteAll() {
        do {
            try! realm.write {
                realm.deleteAll()
            }
        }
    }
    func fetchRealmItems() -> Results<RealmProductItem> {
        return realm.objects(RealmProductItem.self)
    }
    
    
    func addUserToRealm(databaseUser: RealmDatabaseUser) {
        do {
            try realm.write {
                realm.add(databaseUser)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func addOrdersToRealm(orderItem: [RealmDatabaseOrders]) {
        do {
            try realm.write {
                realm.add(orderItem)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
