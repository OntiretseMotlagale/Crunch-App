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

    @Inject var firestoreManager: FirestoreManagerProtocol
    @Inject var authenticationManager: AuthenticationProtocol
    @ObservedResults(RealmDatabaseUser.self) var realmDatabaseUser
    

}
struct PersonalDetailsView: View {
    
    @State private var showAlert: Bool = false
    
    @StateObject private var viewModel = PersonalDataViewModel()
    var body: some View {
        ScrollView(showsIndicators: false){
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
                buildUserProfileInputs()
                    .navigationTitle("Edit Profile")
                CustomButton(title: "Save") {
                    
                }
                
                .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder func buildUserProfileInputs() -> some View {
        VStack  {
            HStack {
                List {
                    VStack(alignment: .leading) {
                        List {
                            Text("Full Name")
                                .foregroundStyle(Color("LightGray"))
                                .fontWeight(.semibold)
                                .padding(.bottom, 5)
                            
                            if let user = viewModel.realmDatabaseUser.first {
                                Text(user.fullname)
                                    .font(.custom(AppFonts.bold, size: 16))
                                    .foregroundStyle(.black)
                            }
                        }
                        Divider()
                            .padding(.bottom, 5)
                    }
                }
            }
            HStack {
                List {
                    VStack(alignment: .leading) {
                        Text("Email")
                            .foregroundStyle(Color("LightGray"))
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)
                        
                        if let user = viewModel.realmDatabaseUser.first {
                            Text(user.email)
                                .font(.custom(AppFonts.bold, size: 16))
                                .foregroundStyle(.black)
                        }
                        Divider()
                            .padding(.bottom, 5)
                    }
                }
            }
        }
    }
}

#Preview {
    
    PersonalDetailsView()
}

