//
//  LoginViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/10.
//

import Foundation
import SwiftUI
import FirebaseAuth


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
    @Published var showAlert: Bool = false
    @Published var showWheel: Bool = false
    
    func signIn() async throws {
        do {
            self.showWheel = true
            try await Auth.auth().signIn(withEmail: email, password: password)
            UserDefaults.isUserSignedIn = true
        }
        catch {
            self.showWheel = false
            print(error.localizedDescription)
        }
    }
    private func clearUserDetails() {
        self.email = ""
        self.password = ""
        self.errorMessage = ""
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        showAlert = true
    }
}
