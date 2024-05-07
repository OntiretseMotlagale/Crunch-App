//
//  PersonalDataView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/04/23.
//

import SwiftUI

struct PersonalDataView: View {
    @State var fullname: String = "Bakang"
    @State var email: String = "Bakang@gmail.com"
    @State var showAlert: Bool = false
    @State var newFullname: String = ""
    @State var newEmail: String = ""
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
    }
    
    @ViewBuilder func buildUserProfileInputs() -> some View {
        VStack  {
            HStack {
                VStack(alignment: .leading) {
                    Text("Full Name")
                        .foregroundStyle(Color("LightGray"))
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    Text(fullname)
                        .fontWeight(.semibold)
                    Divider()
                        .padding(.bottom, 5)
                }
                Button(action: {
                    self.showAlert = true
                    print("You tapped me")
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
                    Text(email)
                        .tint(.black)
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
        }
    }
    
    @ViewBuilder func buildAlert() -> some View {
        buildUserProfileInputs()
            .alert("Edit Full Name", isPresented: $showAlert) {
            TextField("Full Name", text: $newFullname)
            Button(role: .cancel) {
                fullname = newFullname
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
                TextField("Email", text: $newEmail)
                Button(role: .cancel) {
                    email = newEmail
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
    PersonalDataView()
}

