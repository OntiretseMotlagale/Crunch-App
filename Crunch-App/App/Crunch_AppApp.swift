//
//  Crunch_AppApp.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/09.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Crunch_AppApp: App {
   
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let dependencies = Dependencies()
    @AppStorage("isOnboardingDone") var isOnboardingDone: Bool = false
   
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if isOnboardingDone {
                   ContentView()
                }
                else {
                    OnboardingView()
                }
            }
        }
    }
}
