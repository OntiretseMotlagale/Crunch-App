//
//  LoginViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/10.
//

import Foundation
import SwiftUI

enum EmailValidationError: Error {
    case tooShort
    case tooLong
    case invalidCharacterFound(Character)
    
}
protocol LoginProvider {
   var email: Binding<String> { get set }
   var password: Binding<String> { get set }
   var errorMessage: Binding<String> { get set }
    
}

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    @Inject var authenticationProtocol: AuthenticationProtocol
    
    func signIn() async throws {
        do {
            try await authenticationProtocol.loginUser(email: email, password: password)
            clearUserDetails()
            UserDefaults.isUserSignedIn = true
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
