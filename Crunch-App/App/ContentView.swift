//
//  ContentView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/09.
//

import SwiftUI
import FirebaseAuth
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
   private var cancellable = Set<AnyCancellable>()
    
    init() {
        self.setupSubscriber()
    }
    
    func setupSubscriber() {
        AuthenticationManager.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellable)
    }
}
struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        ProfileView()
//        Group {
//            if viewModel.userSession != nil {
//                TabBarView()
//            } else {
//                LoginView()
//            }
//        }
    }
}
#Preview {
    ContentView()
}
