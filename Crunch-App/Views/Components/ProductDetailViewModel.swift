//
//  ProductDetailViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/21.
//

import Foundation
import RealmSwift

class ProductDetailViewModel: ObservableObject {
  
    let realmManager: RealmManager
    
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }
    
    func addItemToRealm(item: ProductModel) {
        let realmProductItem = RealmProductItem()
        realmProductItem.name = item.name
        realmProductItem.descript = item.description
        realmProductItem.image = item.image
        realmProductItem.price = item.price
        realmManager.addItem(realmItem: realmProductItem)
  }
}
