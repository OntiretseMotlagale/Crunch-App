//
//  PersonalDataView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/04/23.
//

import SwiftUI

@MainActor
class PersonalViewModel: ObservableObject {
    @Published private(set) var databaseUser: DatabaseUser? = nil
    
    func loadCurrentUser() async throws {
        let authUser =  try AuthenticationManager.shared.getAuthenticatedUser()
        self.databaseUser = try await FirestoreManager.shared.fetchFirestoreUser(id: authUser)
    }
}
struct PersonalDataView: View {
    @State var fullname: String = ""
    @State var email: String = ""
    @State var dateOfBirth: String = ""
    
    @StateObject var viewModel = PersonalViewModel()
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
                            .fill(.white)}
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

