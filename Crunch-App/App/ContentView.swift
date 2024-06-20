//
//  ContentView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/09.
//

import SwiftUI
import FirebaseAuth

@MainActor
struct ContentView: View {
    let dependencies = Dependencies()
    @AppStorage(UserDefaultsKeys.isUserSignedIn) var isUserLoggedIn: Bool = false
   
    var body: some View {
        Group {
            if isUserLoggedIn {
                TabBarView()
            } else {
                LoginView()
            }

        }
    }
}
#Preview {
    ContentView()
}
