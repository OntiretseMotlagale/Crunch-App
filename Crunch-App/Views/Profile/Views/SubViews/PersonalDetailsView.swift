//
//  PersonalDataView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/04/23.
//

import SwiftUI
import RealmSwift

@MainActor
class PersonalDataViewModel: ObservableObject {

    @Inject var authenticationManager: SignInEmailPasswordProvider
    @ObservedResults(RealmDatabaseUser.self) var realmDatabaseUser
    
}
struct PersonalDetailsView: View {
    
    @State private var showAlert: Bool = false
    
    @StateObject private var viewModel = PersonalDataViewModel()
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack (spacing: 5) {
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
                    .navigationTitle("Profile Data")
                    .navigationBarTitleDisplayMode(.inline)
                
                if let user = viewModel.realmDatabaseUser.first {
                    ProfileTextFieldView(profileData: user.fullname, placeHolder: "FULL NAME")
                }
                if let user = viewModel.realmDatabaseUser.first {
                    ProfileTextFieldView(profileData: user.email, placeHolder: "EMAIL")
                }
            }
        }
    }
    
    @ViewBuilder func buildUserProfileInputs() -> some View {
        VStack  {
            List {
                VStack(alignment: .leading) {
                    Text("Full Name")
                        .foregroundStyle(Color("LightGray"))
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    
                    
                    Divider()
                        .padding(.bottom, 5)
                }
            }
            List {
                VStack(alignment: .leading) {
                    Text("Email")
                        .foregroundStyle(Color("LightGray"))
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    
                    
                    Divider()
                        .padding(.bottom, 5)
                }
            }
        }
    }
}

#Preview {
    
    PersonalDetailsView()
}

