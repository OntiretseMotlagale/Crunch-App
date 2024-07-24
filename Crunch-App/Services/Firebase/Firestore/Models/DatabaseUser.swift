//
//  DatabaseUser.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/07/24.
//

import Foundation
import FirebaseAuth

struct DatabaseUser: Codable {
    var uid: String?
    var fullname: String?
    var email: String?
}
