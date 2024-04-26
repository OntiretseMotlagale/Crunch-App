

import Foundation
import FirebaseCore
import FirebaseAuth



class AuthenticationManager {
    @Published var userSession: FirebaseAuth.User?
    static let shared = AuthenticationManager()
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func registerUser(fullName: String, email: String, password: String) async throws {
        
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
           
        try await FirestoreManager.shared.uploadUser(uid: authResult.user.uid,
                                              fullname: fullName,
                                              email: email,
                                              photoURL: authResult.user.photoURL?.absoluteString ?? "")
        self.userSession = authResult.user
    }
    func loginUser(email: String, password: String) async throws {
        do {
         let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        }
        catch {
            print("Failed to log in")
        }
    }
    
    func signOut() {
        do {
           try Auth.auth().signOut()
           self.userSession = nil
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
