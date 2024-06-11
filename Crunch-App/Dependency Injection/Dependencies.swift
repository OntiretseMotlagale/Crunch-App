//
//  Dependencies.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/06/11.
//

import Foundation
import Swinject

@MainActor
class Dependencies {
    
    init() {
        @Provider var firestoreManager = FirestoreManager() as FirestoreManagerProtocol
        @Provider var authServiceProtocol = AuthenticationManager() as AuthenticationProtocol
        @Provider var registerProtocol = RegisterViewModel() as RegisterUserProtocol
    }
}
