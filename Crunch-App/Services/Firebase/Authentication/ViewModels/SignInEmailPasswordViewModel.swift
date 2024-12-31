import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift


protocol SignInEmailPasswordProvider {
    func registerUser(fullName: String, email: String, password: String) async throws
    func signOut()
    func getAuthenticatedUser() throws -> String
}

enum AuthProviderOptions: String {
    case email = "password"
    case google = "google.com"
}

class SignInEmailPasswordViewModel: SignInEmailPasswordProvider {

    @Inject var userProvider: UserProvider

    func registerUser(fullName: String, email: String, password: String) async throws {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let newUser = DatabaseUser(uid: authResult.user.uid, fullname: fullName, email: email, orders: [])
        try await userProvider.uploadUserToDatabase(user: newUser)
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

