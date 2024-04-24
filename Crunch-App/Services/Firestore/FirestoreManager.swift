
import Foundation
import FirebaseAuth
import FirebaseFirestore

struct DatabaseUser {
    var uid: String
    var fullname: String
    var email: String
    var photoURL: URL
    var dateCreated: Date
}

@MainActor
class FirestoreManager {
    static let shared = FirestoreManager()
    func uploadUser(uid: String, fullname: String, email: String, photoURL: String) async throws {
        let userData: [String : Any] = [
            "uid": uid,
            "fullname": fullname,
            "email": email,
            "photoURL": photoURL
        ]
        do {
            try await Firestore.firestore().collection("users").document(uid).setData(userData)
        }
        catch {
            throw URLError(.badURL)
        }
    }
}
