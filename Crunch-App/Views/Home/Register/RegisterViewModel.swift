//
//  RegisterViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/10.
//

import Foundation

enum RegistrationError: Error {
    case fullnameEmpty
    case emailEmpty
    case passwordEmpty
    case passwordTooShort
    
}
@MainActor
class RegisterViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var isAccountCreated: Bool = false
    
    let authService: AuthenticationManager
    init(authService: AuthenticationManager) {
        self.authService = authService
    }
    
    func register() async throws {
        do {
            try await authService.registerUser(fullName: fullName, email: email, password: password)
            clearUserDetails()
            self.isAccountCreated = true
        }
        catch let error {
            self.errorMessage = error.localizedDescription
        }
    }
    private func clearUserDetails() {
        self.email = ""
        self.password = ""
        self.fullName = ""
        self.errorMessage = ""
    }

}
