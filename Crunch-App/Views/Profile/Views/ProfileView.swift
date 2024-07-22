//
//  ProfileView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/23.
//

import Foundation
import SwiftUI
import FirebaseAuth
import RealmSwift

enum ProfileIcons: String {
    case house
    case address
    case bag
    case settings
}


@MainActor
class ProfileViewModel: ObservableObject {
    @Published private(set) var databaseUser: DatabaseUser? = nil
    @Published var authProviderOption: [AuthProviderOptions] = []
    @Inject var userProvider: UserProvider
    @Inject var googleProvider: SignInGoogleProvider
    @Inject var signInEmailPasswordProvider: SignInEmailPasswordProvider
    @ObservedResults(RealmDatabaseUser.self) var realmDatabaseUser
    
    let realmManager: RealmManager
    
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }
    func signOut() {
        signInEmailPasswordProvider.signOut()
        UserDefaults.isUserSignedIn = false
    }
    
    func deleteAll() {
        realmManager.deleteAll()
    }
    func loadCurrentUser() async throws {
        let userID =  try signInEmailPasswordProvider.getAuthenticatedUser()
        self.databaseUser = try await userProvider.getUser(userID: userID)
        addToRealm()
    }
    func addToRealm() {
        let realmDatabaseUser = RealmDatabaseUser()
        realmDatabaseUser.fullname = databaseUser?.fullname ?? "No Name"
        realmDatabaseUser.email = databaseUser?.email ?? "No Email"
        realmManager.addUserToRealm(databaseUser: realmDatabaseUser)
    }
    func getAuthProviders() {
        if let authProvider = try? googleProvider.getProviders() {
            self.authProviderOption = authProvider
            print(authProviderOption)
        }
    }
}
struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel(realmManager: RealmManager())
    @State var profileData: [ProfileModel] = [
        ProfileModel(name: "Personal Details",
                     iconName: "person.fill",
                     Tab: .personalDetails),
        ProfileModel(name: "Address",
                     iconName: "house",
                     Tab: .address),
        ProfileModel(name: "Orders",
                     iconName: "bag",
                     Tab: .orders),
        ProfileModel(name: "Settings",
                     iconName: "gearshape",
                     Tab: .settings)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ProfileImage()
                        .padding(.bottom, 30)
                    HStack (spacing: 30) {
                        Image(systemName: "checkmark.seal")
                            .imageScale(.large)
                            .symbolRenderingMode(.multicolor)
                            .foregroundStyle(.white)
                        if let user = viewModel.realmDatabaseUser.first {
                            Text(user.fullname)
                                .font(.custom(AppFonts.bold, size: 20))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(AppColors.primaryColor))
                    .padding(.bottom, 20)
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(profileData) { item in
                            if viewModel.authProviderOption.contains(.google) {
                                
                            }
                            if viewModel.authProviderOption.contains(.email) {
                                ProfileDetailButton(item: item, selectedTab: .orders)
                            }
                          
                        }
                    }
                    .padding(.bottom, 30)
                    Button(action: {
                        viewModel.signOut()
                        viewModel.deleteAll()
                    }, label: {
                        HStack(spacing: 10) {
                           Image(systemName:  "door.left.hand.open")
                                .imageScale(.large)
                                .foregroundStyle(.red)
                            Text("Logout")
                                .font(.custom(AppFonts.bold, size: 16))
                                .foregroundStyle(.pink)
                        }
                    })
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .frame(height: 50)
                    .padding(.horizontal)
                }
                .navigationTitle("My Profile")
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding(.horizontal)
            .background(
                AppColors.primaryLightGray
                    .ignoresSafeArea())
        }
        .onAppear {
            viewModel.getAuthProviders()
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
        VStack (alignment: .leading, spacing: 0){
            GroupBox {
                NavigationLink {
                    ProfileScreens(selectedTab: selectedTab)
                } label: {
                    HStack {
                        HStack(spacing: 15) {
                            Image(systemName: item.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            Text(item.name)
                                .font(.custom(AppFonts.semibold, size: 15))
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                    }
            }
                .frame(height: 30)
            }
        }
        .padding(.vertical, 8)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
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


