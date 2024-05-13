//
//  PersonalDataView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/04/23.
//

import SwiftUI

@MainActor
class PersonalViewModel: ObservableObject {
    let profileViewModel: ProfileViewModel
    
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
    }
    
    func loadCurrentUser() async {
       try await profileViewModel.loadCurrentUser()
    }
}
struct PersonalDataView: View {
    @State var fullname: String = ""
    @State var email: String = ""
    @State var dateOfBirth: String = ""
    
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        ScrollView {
            VStack {
                ProfileImage()
                    .overlay(alignment: .bottomTrailing) {
                        Button(action: {}, label: {
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 35)
                                .foregroundStyle(Color("primaryPurple"))
                        })
                        .background {
                            Circle()
                                .fill(.white)
                        }
                    }
                    .padding(.bottom, 30)
                VStack (alignment: .leading) {
                    Text("Full Name")
                        .foregroundStyle(Color("LightGray"))
                        .padding(.bottom, 5)
                    if let fullname = viewModel.databaseUser?.fullname {
                        Text(fullname)
                    }
                    Divider()
                        .padding(.bottom, 5)
                    
                        Text("Email")
                            .foregroundStyle(Color("LightGray"))
                            .padding(.bottom, 5)
                if let email =  viewModel.databaseUser {
                    Text(email.email ?? "No Email")
                        .tint(.black)
                }
                    Divider()
                }
            }
            .padding(.horizontal)
            .navigationTitle("Edit Profile")
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
    }
}

#Preview {
    PersonalDataView()
}

