
import Foundation
import FirebaseAuth
import FirebaseFirestore

struct DatabaseUser {
    var uid: String?
    var fullname: String?
    var email: String?
    var photoURL: String?
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
    
    func fetchFirestoreUser(id: String) async throws -> DatabaseUser {
        let documentSnapshot = try await Firestore.firestore().collection("users").document(id).getDocument()
        guard let data = documentSnapshot.data() else {
            throw URLError(.cannotOpenFile)
        }
        let uid = data["uid"] as? String
        let email = data["email"] as? String
        let fullname = data["fullname"] as? String
        let photoURL = data["photoURL"] as? String
        
        return DatabaseUser(uid: uid, fullname: fullname, email: email, photoURL: photoURL)
    }
}
