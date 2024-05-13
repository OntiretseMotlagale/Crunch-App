//
//  ProfileView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/23.
//

import Foundation
import SwiftUI
import FirebaseAuth


struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State var profileData: [ProfileModel] = [
        ProfileModel(name: "Personal Data",
                     iconName: "person",
                     Tab: .personalData),
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
                    Text("Ontiretse Motlagale")
                        .font(.title.bold())
                    HStack (spacing: 30) {
                        Image(systemName: "bubbles.and.sparkles.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color("primaryPurple"))
                            .frame(width: 30, height: 30)
                        VStack(alignment: .leading) {
                            Text("30 Mar, 1997")
                                .fontWeight(.bold)
                                .foregroundStyle(Color("primaryPurple"))
                            Text("Birth Date")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("primaryPurple")))
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
                        HStack(spacing: 15) {
                            Image("logout")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Logout")
                                .font(.system(size: 20))
                                .foregroundStyle(.black)
                        }
                    })
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }
                .navigationTitle("My Profile")
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding(.horizontal)
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
                        .foregroundStyle(Color("primaryPurple"))
                        .frame(width: 25, height: 25)
                    Text(item.name)
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .fontWeight(.bold)
                        .foregroundStyle(Color("PrimaryGray"))
                }
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color("LightWhite")))
    }
}

#Preview {
    /*ProfileDetailButton*/
    ProfileView()
}

enum ProfileCategory: CaseIterable {
    case personalData
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
            case .personalData:
               PersonalDataView()
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


