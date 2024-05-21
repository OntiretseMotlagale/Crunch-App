//
//  CartViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/22.
//

import Foundation
import RealmSwift


struct UsableCartItems: Hashable {
    var id = UUID().uuidString
    var name: String
    var image: String
    var price: Int
    var descript: String
    
    init(name: String,
         image: String,
         price: Int,
         descript: String) {
        self.name = name
        self.image = image
        self.price = price
        self.descript = descript
    }
}
class CartViewModel: ObservableObject {
    @Published var total: Int = 0
    @Published var useableCartItems: [UsableCartItems] = []
    @Published var cartItems: Results<RealmProductItem>! {
        didSet {
            self.calculateTotal()
        }
    }
    let realmManager: RealmManager
    let realm = try! Realm()
    
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
        fetchItems()
        calculateTotal()
        mapUsableCartItems()
    }
    
    private func mapUsableCartItems() {
        self.useableCartItems = cartItems.map {
            UsableCartItems(name: $0.name,
                              image: $0.image,
                              price: $0.price,
                              descript: $0.descript)
        }
    }
   private func calculateTotal() {
        mapUsableCartItems()
        total = 0
        for items in useableCartItems {
            total += items.price 
        }
    }
    private func fetchItems() {
        cartItems = realmManager.fetchRealmItems()
    }
    
    func deleteItem(at offSet: IndexSet) {
        offSet.forEach { index in
            realmManager.deleteItem(item: cartItems[index])
        }
        fetchItems()
    }
}
