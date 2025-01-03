//
//  ProfileTextFieldView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/06/19.
//

import SwiftUI

struct ProfileTextFieldView: View {
    let profileData: String
    let placeHolder: String
    
    init(profileData: String, placeHolder: String) {
        self.profileData = profileData
        self.placeHolder = placeHolder
    }
    
    var body: some View {
        VStack {
            GroupBox {
                VStack {
                    Text(placeHolder)
                        .font(.custom(AppFonts.regular, size: 13))
                        .foregroundStyle(AppColors.lightGray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Text(profileData)
                        .font(.custom(AppFonts.regular, size: 18))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 23)
            }
            .padding(.bottom)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileTextFieldView(profileData: "Ontiretse Motlagale", placeHolder: "FULL NAME")
}

