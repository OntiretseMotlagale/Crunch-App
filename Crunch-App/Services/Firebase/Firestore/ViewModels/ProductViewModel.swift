//
//  ProductViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/07/22.
//

import Foundation
import FirebaseFirestore



protocol ProductProvider {
    func getProductItems(from: String, collection collectionName: String) async throws -> [DatabaseProductItem]
}

enum ProductKey: String {
    case products
}
class ProductViewModel: ProductProvider {
     
    private func productDocument(docName: String) -> DocumentReference {
        let productFirestoreReference = Firestore.firestore().collection(DatabaseCollectionType.products.rawValue)
       return productFirestoreReference.document(docName)
    }

    func getProductItems(from: String, collection collectionName: String) async throws -> [DatabaseProductItem] {
        let snapshot = try await productDocument(docName: from).collection(collectionName).getDocuments()
        do {
            let productItems = snapshot.documents.compactMap { document -> DatabaseProductItem? in
              return try? document.data(as: DatabaseProductItem.self)
            }
            return productItems
        }
    }
}
