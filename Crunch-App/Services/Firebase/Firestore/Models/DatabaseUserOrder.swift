//
//  DatabaseUserOrder.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/07/24.
//

import Foundation
import FirebaseFirestore

struct DatabaseUserOrder: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var uid: String?
    var productImage: String?
    var productname: String?
    var price: Int?
    var date: Date
}
