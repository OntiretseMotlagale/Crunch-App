//
//  ProfileView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

@MainActor
class ProfileViewModel: ObservableObject {
    @Published private(set) var databaseUser: DatabaseUser? = nil
    
    func signOut() {
        AuthenticationManager.shared.signOut()
    }
    
    func loadCurrentUser() async throws {
        let authUser =  try AuthenticationManager.shared.getAuthenticatedUser()
        self.databaseUser = try await FirestoreManager.shared.fetchFirestoreUser(id: authUser)
    }
}
struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State var profileData: [ProfileModel] = [
        ProfileModel(name: "Personal Details",
                     iconName: "person",
                     Tab: .personalDetails),
        ProfileModel(name: "Address",
                     iconName: "house",
                     Tab: .address),
        ProfileModel(name: "Orders",
                     iconName: "bag",
                     Tab: .orders),
        ProfileModel(name: "Setting",
                     iconName: "gearshape",
                     Tab: .settings)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ProfileImage()
                        .padding(.bottom, 30)
                    if let fullname = viewModel.databaseUser?.fullname {
                        Text(fullname)
                            .font(.title.bold())
                    }
                    HStack (spacing: 30) {
                        Image(systemName: "bubbles.and.sparkles.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 30)
                        VStack(alignment: .leading) {
                            Text("30 Mar, 1997")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Text("Birth Date")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(AppColors.primaryColor))
                    .padding(.bottom, 20)
                    VStack {
                        ForEach(profileData) { item in
                            ProfileDetailButton(item: item, selectedTab: item.Tab )
                                .padding(.bottom, 10)
                        }
                    }
                    .padding(.bottom, 30)
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        HStack(spacing: 40) {
                            Text("Logout")
                                .font(.system(size: 25))
                                .fontWeight(.thin)
                                .foregroundStyle(.white)
                        }
                    })
                   
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .frame(height: 50)
                    .background(Color.red)
                    .cornerRadius(30)
                    .padding(.horizontal)
                }
                .navigationTitle("My Profile")
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding(.horizontal)
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
    }
}

struct ProfileDetailButton: View {
    let item: ProfileModel
    @State var selectedTab: ProfileCategory
    
    var body: some View {
        VStack {
            NavigationLink {
                ProfileScreens(selectedTab: selectedTab)
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: item.iconName)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                    Text(item.name)
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(AppColors.primaryColor))
    }
}

#Preview {
    /*ProfileDetailButton*/
    ProfileView()
}

enum ProfileCategory: CaseIterable {
    case personalDetails
    case orders
    case address
    case settings
}

struct ProfileModel: Identifiable {
    var id = UUID()
    var name: String
    var iconName: String
    var Tab: ProfileCategory
}

struct ProfileScreens: View {
    var selectedTab: ProfileCategory
    var body: some View {
        VStack {
            switch selectedTab {
            case .personalDetails:
                PersonalDetailsView()
            case .orders:
                OrdersView()
            case .address:
                AddressView()
            case .settings:
                SettingsView()
            }
        }
    }
}


