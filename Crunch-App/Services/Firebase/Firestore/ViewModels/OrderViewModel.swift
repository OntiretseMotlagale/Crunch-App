import Foundation
import FirebaseFirestore

protocol OrderProvider {
    func uploadOrderItem(order: DatabaseUserOrder) async throws
    func fetchOrderItems( userID: String) async throws -> [DatabaseUserOrder]
}
class OrderViewModel: OrderProvider {
  
    func orderDocument(uid: String) -> DocumentReference {
        let orderFirestoreReference = Firestore.firestore().collection(DatabaseCollectionType.orders.rawValue)
        return orderFirestoreReference.document(uid)
    }
    
    func uploadOrderItem(order: DatabaseUserOrder) async throws {
        guard let uid = order.uid else {
            return
        }
        try orderDocument(uid: uid).collection(uid).addDocument(from: order)
    }
    
    func fetchOrderItems(userID: String) async throws -> [DatabaseUserOrder] {
        let ordersCollection = orderDocument(uid: userID).collection(userID)
        do {
            let snapshot = try await ordersCollection.getDocuments()
            let orderItems = snapshot.documents.compactMap { document -> DatabaseUserOrder? in
                try? document.data(as: DatabaseUserOrder.self)
            }
            return orderItems
        } catch {
            throw error
        }
    }
}

