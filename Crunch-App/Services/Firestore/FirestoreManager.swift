
import Foundation
import FirebaseAuth
import FirebaseFirestore


protocol FirestoreManagerProtocol {
    func uploadUser(uid: String, fullname: String, email: String, photoURL: String) async throws
    func fetchFirestoreUser(id: String) async throws -> DatabaseUser
    func uploadOrderItem(uid: String, image: String, itemName: String, price: Int) async throws
    func fetchOrderItems( userID: String) async throws -> [DatabaseUserOrder]
    
}
struct DatabaseUserOrder: Identifiable, Decodable {
    var id = UUID().uuidString
    var uid: String?
    var productImage: String?
    var productname: String?
    var price: Int?
}
struct DatabaseUser {
    var uid: String?
    var fullname: String?
    var email: String?
    var photoURL: String?
}

@MainActor
class FirestoreManager: FirestoreManagerProtocol {
    
    private let userFirestoreReference = Firestore.firestore().collection("users")
    private let orderFirestoreReference = Firestore.firestore().collection("orders")
    
    func uploadUser(uid: String, fullname: String, email: String, photoURL: String) async throws {
        let userData: [String : Any] = [
            "uid": uid,
            "fullname": fullname,
            "email": email,
            "photoURL": photoURL
        ]
        do {
            try await userFirestoreReference.document(uid).setData(userData)
        }
        catch {
            throw URLError(.badURL)
        }
    }
    func fetchFirestoreUser(id: String) async throws -> DatabaseUser {
        let documentSnapshot = try await userFirestoreReference.document(id).getDocument()
        guard let data = documentSnapshot.data() else {
            throw URLError(.badURL)
        }
        
        let uid = data["uid"] as? String
        let email = data["email"] as? String
        let fullname = data["fullname"] as? String
        let photoURL = data["photoURL"] as? String
        
        return DatabaseUser(uid: uid, 
                            fullname: fullname,
                            email: email,
                            photoURL: photoURL)
    }
    
    func uploadOrderItem(uid: String, image: String, itemName: String, price: Int) async throws {
        let orderData: [String: Any] = [
            "uid": uid,
            "Product_Image" : image,
            "Product_Name" : itemName,
            "Product_Price": price
        ]
        do {
            try await orderFirestoreReference.document(uid).collection(uid).addDocument(data: orderData)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchOrderItems( userID: String) async throws -> [DatabaseUserOrder] {
        let db = Firestore.firestore()
        let ordersCollection = db.collection("orders").document(userID).collection(userID)
        
        do {
            let snapshot = try await ordersCollection.getDocuments()
            let orderItems = snapshot.documents.compactMap { document -> DatabaseUserOrder? in
                let orderData = document.data()
                
                let uid = orderData["uid"] as? String ?? ""
                let image = orderData["Product_Image"] as? String ?? ""
                let itemName = orderData["Product_Name"] as? String ?? ""
                let price = orderData["Product_Price"] as? Int ?? 0
                return DatabaseUserOrder(uid: uid,
                                         productImage: image,
                                         productname: itemName,
                                         price: price)
            }
            return orderItems
        } catch {
            throw error
        }
    }
}
