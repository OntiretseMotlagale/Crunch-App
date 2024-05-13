//
//  ProfileViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/05/07.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    func signOut() {
        AuthenticationManager.shared.signOut()
    }
}
