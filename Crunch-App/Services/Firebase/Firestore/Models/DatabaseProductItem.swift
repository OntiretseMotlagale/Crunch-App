//
//  DatabaseProductItem.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/07/24.
//

import Foundation

struct DatabaseProductItem: Identifiable, Codable {
    var id: String = UUID().uuidString
    var gallery: [String]?
    var description: String?
    var image: String?
    var name: String?
    var price: Int?
}
