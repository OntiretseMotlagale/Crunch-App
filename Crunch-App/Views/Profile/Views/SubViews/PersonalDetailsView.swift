//
//  PersonalDataView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/04/23.
//

import SwiftUI

class PersonalDataViewModel: ObservableObject {
    @Published private(set) var databaseUser: DatabaseUser? = nil
    @Published var newFullname: String = ""
    @Published var newEmail: String = ""

    func loadCurrentLoggedInUser() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        self.databaseUser = try await FirestoreManager.shared.fetchFirestoreUser(id: authUser)
    }
}
struct PersonalDetailsView: View {
    @State var fullname: String = ""
    @State var email: String = ""
    @State var showAlert: Bool = false
  
    
    @StateObject var viewModel = PersonalDataViewModel()
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
                buildAlert()
                   
                    .navigationTitle("Edit Profile")
                CustomButton(title: "Save") {
                    
                }
            }
            .padding(.horizontal)
        }
        .task {
            try? await viewModel.loadCurrentLoggedInUser()
        }
    }
    
    @ViewBuilder func buildUserProfileInputs() -> some View {
        VStack  {
            HStack {
                VStack(alignment: .leading) {
                    Text("Full Name")
                        .foregroundStyle(Color("LightGray"))
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    if let fullname = viewModel.databaseUser?.fullname {
                        Text(fullname)
                            .fontWeight(.semibold)
                    }
                    Divider()
                        .padding(.bottom, 5)
                }
                Button(action: {
                    self.showAlert.toggle()
                }, label: {
                    Text("Edit")
                        .fontWeight(.semibold)
                        .foregroundStyle(AppColors.textColor)
                })
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Email")
                        .foregroundStyle(Color("LightGray"))
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    if let email = viewModel.databaseUser?.email {
                        Text(email)
                            .tint(.black)
                            .fontWeight(.semibold)
                    }
                    Divider()
                        .padding(.bottom, 5)
                }
                Button(action: {
                    self.showAlert.toggle()
                }, label: {
                    Text("Edit")
                        .fontWeight(.semibold)
                        .foregroundStyle(AppColors.textColor)
                })
            }
        }
    }
    @ViewBuilder func buildAlert() -> some View {
        buildUserProfileInputs()
            .alert("Edit Full Name", isPresented: $showAlert) {
                TextField("Full Name", text: $viewModel.newFullname)
            Button(role: .cancel) {
                fullname = viewModel.newFullname
            } label: {
                Text("Save")
            }
            Button(role: .destructive) {
                self.showAlert = false
            } label: {
                Text("Cancel")
            }
        }
            .alert("Edit Email", isPresented: $showAlert) {
                TextField("Email", text: $viewModel.newEmail)
                Button(role: .cancel) {
                    email = viewModel.newEmail
                } label: {
                    Text("Save")
                }
                Button(role: .destructive) {
                    self.showAlert = false
                } label: {
                    Text("Cancel")
                }
            }
    }
}

#Preview {
    PersonalDetailsView()
}

