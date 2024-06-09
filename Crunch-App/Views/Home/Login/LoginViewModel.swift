//
//  LoginViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/10.
//

import Foundation

enum EmailValidationError: Error {
    case tooShort
    case tooLong
    case invalidCharacterFound(Character)
    
}
@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    func signIn() async throws {
        do {
            try await AuthenticationManager.shared.loginUser(email: email, password: password)
            clearUserDetails()
        }
        catch let error {
            self.errorMessage = error.localizedDescription
        }
    }
    private func clearUserDetails() {
        self.email = ""
        self.password = ""
        self.errorMessage = ""
    }
}
