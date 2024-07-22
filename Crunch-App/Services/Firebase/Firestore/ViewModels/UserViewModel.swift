//
//  UserViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/07/22.
//

import Foundation
import FirebaseFirestore


struct DatabaseUser: Codable {
    var uid: String?
    var fullname: String?
    var email: String?
}

protocol UserProvider {
    func uploadUser(user: DatabaseUser) async throws
    func getUser(userID: String) async throws -> DatabaseUser
}

class UserViewModel: UserProvider {
    
    private let userFirestoreReference = Firestore.firestore().collection("users")
    
    private func userDocument(uid: String) -> DocumentReference {
        return userFirestoreReference.document(uid)
    }
    
    func uploadUser(user: DatabaseUser) async throws {
        guard let id = user.uid else {
            return
        }
        try userDocument(uid: id).setData(from: user)
    }
    func getUser(userID: String) async throws -> DatabaseUser  {
        return try await userDocument(uid: userID).getDocument(as: DatabaseUser.self)
    }
}

