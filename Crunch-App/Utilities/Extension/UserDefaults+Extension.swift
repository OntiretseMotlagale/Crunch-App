//
//  UserDefaults.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/06/11.
//

import Foundation

enum UserDefaultsKeys {
    static var isUserSignedIn = "isUserSignedIn"
}

extension UserDefaults {
    static var isUserSignedIn: Bool? {
        get {
            return UserDefaults.standard.value(forKey: UserDefaultsKeys.isUserSignedIn) as? Bool
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isUserSignedIn)
        }
    }
}
