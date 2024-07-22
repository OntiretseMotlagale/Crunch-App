import Foundation
import FirebaseFirestore

struct DatabaseUserOrder: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var uid: String?
    var productImage: String?
    var productname: String?
    var price: Int?
}

protocol OrderProvider {
    func uploadOrderItem(uid: String, image: String, itemName: String, price: Int) async throws
    func fetchOrderItems( userID: String) async throws -> [DatabaseUserOrder]
}

class OrderViewModel: OrderProvider {

    private let orderFirestoreReference = Firestore.firestore().collection("orders")
    
    func orderDocument(uid: String) -> DocumentReference {
        orderFirestoreReference.document(uid)
    }
    func uploadOrderItem(order: DatabaseUserOrder) async throws {
        guard let uid = order.uid else {
           return
        }
        try orderDocument(uid: uid).collection(uid).addDocument(from: order)
    }
    func uploadOrderItem(uid: String, image: String, itemName: String, price: Int) async throws {
        let orderData: [String: Any] = [
            "uid": uid,
            "Product_Image" : image,
            "Product_Name" : itemName,
            "Product_Price": price
        ]
        do {
            try await orderDocument(uid: uid).collection(uid).addDocument(data: orderData)
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
