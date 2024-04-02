//
//  LoginViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/10.
//

import Foundation
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""

    
    func signIn() async throws {
        do {
            try await AuthenticationManager.shared.loginUser(email: email, password: password)
        }
        catch {
            print("Cannot log in \(error.localizedDescription)")
        }
    }
}
