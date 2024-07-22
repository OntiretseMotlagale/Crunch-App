//
//  ProductViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/07/22.
//

import Foundation
import FirebaseFirestore

protocol ProductProvider {
    func fetchProductItems(from: String, collection collectionName: String) async throws -> [DatabaseProductItem]
}

class ProductViewModel: ProductProvider {
    
    private let productFirestireReference = Firestore.firestore().collection("products")
    
    func fetchProductItems(from: String, collection collectionName: String) async throws -> [DatabaseProductItem] {
        let documentSnapshot = try await productFirestireReference.document(from).collection(collectionName).getDocuments()
        do {
            let orderItems = documentSnapshot.documents.compactMap { document -> DatabaseProductItem? in
                let orderData = document.data()
              
                let uid = orderData["id"] as? String ?? ""
                let image = orderData["image"] as? String ?? ""
                let itemName = orderData["name"] as? String ?? ""
                let price = orderData["price"] as? Int ?? 0
                let description = orderData["description"] as? String ?? ""
                let gallery = orderData["gallery"] as? [String] ?? []
                                
                return DatabaseProductItem(id: uid, gallery: gallery, description: description, image: image, name: itemName, price: price)
            }
            return orderItems
        }
    }
}
