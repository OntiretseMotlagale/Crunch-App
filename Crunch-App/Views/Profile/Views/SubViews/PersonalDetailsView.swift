//
//  PersonalDataView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/04/23.
//

import SwiftUI

@MainActor
class PersonalDataViewModel: ObservableObject {
    @Published private(set) var databaseUser: DatabaseUser? = nil
    @Published var newFullname: String = ""
    @Published private var fullname: String = ""
    @Inject var firestoreManager: FirestoreManagerProtocol
    @Inject var authenticationManager: AuthenticationProtocol

    func loadCurrentLoggedInUser() async throws {
        let authUser = try authenticationManager.getAuthenticatedUser()
        self.databaseUser = try await firestoreManager.fetchFirestoreUser(id: authUser)
    }
    
    func getFullname() -> String {
        if let fullname = databaseUser?.fullname { return fullname }
        return ""
    }
    
    func getEmail() -> String {
        if let email = databaseUser?.email { return email }
        return ""
    }
    func editFullname() {
         newFullname = getFullname()
    }
}
struct PersonalDetailsView: View {
    
    @State private var showAlert: Bool = false
  
   @StateObject private var viewModel = PersonalDataViewModel()
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
                                .foregroundStyle(Color(AppColors.primaryColor))
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
                   
                    Text(viewModel.getFullname())
                            .fontWeight(.semibold)
                    
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
                    
                    Text(viewModel.getEmail())
                            .tint(.black)
                            .fontWeight(.semibold)
                    Divider()
                        .padding(.bottom, 5)
                }
            }
        }
    }
    @ViewBuilder func buildAlert() -> some View {
        buildUserProfileInputs()
            .alert("Edit Full Name", isPresented: $showAlert) {
                TextField("Full Name", text: $viewModel.newFullname)
            Button(role: .cancel) {
                viewModel.editFullname()
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

