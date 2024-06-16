//
//  RegisterViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/10.
//

import Foundation

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
     
    
    @Inject var firestoreManager: FirestoreManagerProtocol
    @Inject var authenticationProtocol: AuthenticationProtocol

    func register() async throws {
        do {
            try await authenticationProtocol.registerUser(fullName: fullName, email: email, password: password)
            clearUserDetails()
            self.isAccountCreated = true
        }
        catch let error {
            self.errorMessage = error.localizedDescription
        }
    }
    func clearUserDetails() {
        self.email = ""
        self.password = ""
        self.fullName = ""
        self.errorMessage = ""
    }
    
}
