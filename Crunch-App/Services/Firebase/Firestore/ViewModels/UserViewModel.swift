//
//  UserViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/07/22.
//

import Foundation
import FirebaseFirestore

protocol UserProvider {
    func uploadUserToDatabase(user: DatabaseUser) async throws
    func getUser(userID: String) async throws -> DatabaseUser
}

enum DatabaseCollectionType: String {
    case users
    case orders
    case products
}
class UserViewModel: UserProvider {
    
    private func userDocument(uid: String) -> DocumentReference {
        let userFirestoreReference = Firestore.firestore().collection(DatabaseCollectionType.users.rawValue)
        return userFirestoreReference.document(uid)
    }
    
    func uploadUserToDatabase(user: DatabaseUser) async throws {
        guard let id = user.uid else {
            return
        }
        try userDocument(uid: id).setData(from: user)
    }
    func getUser(userID: String) async throws -> DatabaseUser  {
        return try await userDocument(uid: userID).getDocument(as: DatabaseUser.self)
    }
}

