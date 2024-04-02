//
//  RegisterViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/10.
//

import Foundation
class RegisterViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    let authService: AuthenticationManager
    init(authService: AuthenticationManager) {
        self.authService = authService
    }
    
    func register() {
        authService.registerUser(fullName: fullName, email: email, password: password)
    }
}
