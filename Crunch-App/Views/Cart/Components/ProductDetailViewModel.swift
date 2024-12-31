//
//  ProductDetailViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/21.
//

import Foundation
import RealmSwift

protocol RealmProductItemProvider {
    func addItemToRealm(item: DatabaseProductItem)
}
class ProductDetailViewModel: ObservableObject, RealmProductItemProvider {
  
    let realmManager: RealmManager
    
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }
    
    func addItemToRealm(item: DatabaseProductItem) {
        let realmProductItem = RealmProductItem()
        realmProductItem.name = item.name ?? ""
        realmProductItem.descript = item.description ?? ""
        realmProductItem.image = item.image ?? ""
        realmProductItem.price = item.price ?? 0
        realmManager.addItem(realmItem: realmProductItem)
  }
}
