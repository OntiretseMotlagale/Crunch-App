import Foundation
import FirebaseFirestore

protocol OrderProvider {
      func addOrderToUser(newOrder: DatabaseUserOrder) async throws
}
class OrderViewModel: OrderProvider {
  
    func orderDocument(uid: String) -> DocumentReference {
        let userFirestoreReference = Firestore.firestore().collection(DatabaseCollectionType.users.rawValue)
        return userFirestoreReference.document(uid)
    }
    
    
    func addOrderToUser(newOrder: DatabaseUserOrder) async throws {
        guard let uid = newOrder.uid else { return }
        let orderRef = orderDocument(uid: uid)
        
        let document = try await orderRef.getDocument()
     
        var user = try document.data(as: DatabaseUser.self)
            user.orders?.append(newOrder)
            try orderRef.setData(from: user)
    }
}

