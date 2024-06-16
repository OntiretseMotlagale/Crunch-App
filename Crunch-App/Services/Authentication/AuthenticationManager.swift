

import Foundation
import FirebaseCore
import FirebaseAuth
import Combine

protocol AuthenticationProtocol {
    func registerUser(fullName: String, email: String, password: String) async throws
    func loginUser(email: String, password: String) async throws
    func signOut()
    func getAuthenticatedUser() throws -> String 
}
class AuthenticationManager: AuthenticationProtocol, ObservableObject{

    @Inject var firestoreManager: FirestoreManagerProtocol

    func registerUser(fullName: String, email: String, password: String) async throws {
        
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
           
        try await firestoreManager.uploadUser(uid: authResult.user.uid,
                                              fullname: fullName,
                                              email: email,
                                              photoURL: authResult.user.photoURL?.absoluteString ?? "")
    }
    func loginUser(email: String, password: String) async throws {
        do {
         try await Auth.auth().signIn(withEmail: email, password: password)
        }
        catch {
            print("Failed to log in")
        }
    }
    
    func signOut() {
        do {
           try Auth.auth().signOut()
        }
        catch {
            print("Unable to log out \(error.localizedDescription)")
        }
    }
    
    func getAuthenticatedUser() throws -> String {
        guard let user = Auth.auth().currentUser?.uid else {
            throw URLError(.badURL)
        }
        return user
    }
}
