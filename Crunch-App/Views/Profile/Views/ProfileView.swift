//
//  ProfileView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    
    func signOut() {
        AuthenticationManager.shared.signOut()
    }
}
struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
            VStack {
                Image("profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .border(Color.green, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .cornerRadius(90)
                    .overlay(alignment: .bottomTrailing) {
                        Button(action: {}, label: {
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.red)
                        })
                    }
            }
            .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView()
}
