//
//  RegisterViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/10.
//

import Foundation
import FirebaseAuth

@MainActor
protocol RegisterUserProtocol: ObservableObject {
    var fullName: String { get set }
    var email: String { get set }
    var password: String { get set }
    var errorMessage: String { get set }
    var isAccountCreated: Bool { get set }
    
    func register() async throws
    func clearUserDetails()
}


class RegisterViewModel: RegisterUserProtocol {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var isAccountCreated: Bool = false
    @Published var showAlert: Bool = false
    
    
    @Inject var googleProvider: SignInGoogleProvider
    @Inject var emailPasswordAuthProvider: SignInEmailPasswordProvider
    
    func register() async {
        do {
            try await emailPasswordAuthProvider.registerUser(fullName: fullName, email: email, password: password)
        }
        catch {
            showError(error.localizedDescription)
        }
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        showAlert = true
    }
    
    func registerWithGoogle() async throws {
        do {
            try await googleProvider.signWithGoogle()
            UserDefaults.isUserSignedIn = true
        }
        catch {
            print(error.localizedDescription)
        }
    }
    func clearUserDetails() {
        self.email = ""
        self.password = ""
        self.fullName = ""
        self.errorMessage = ""
    }
    
}
