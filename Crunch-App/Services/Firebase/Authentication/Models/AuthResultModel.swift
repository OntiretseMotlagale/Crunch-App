//
//  AuthResultModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/07/24.
//

import Foundation
import FirebaseAuth


struct AuthResultModel {
    let uid: String?
    let fullName: String?
    let email: String?
    let photoURL: String?
    
    init(user: User) {
        self.email = user.email
        self.uid = user.uid
        self.fullName = user.displayName
        self.photoURL = user.photoURL?.absoluteString
    }
}
