//
//  Dependencies.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/06/11.
//

import Foundation
import Swinject

@MainActor
class Dependencies {
    init() {
        @Provider var userViewModel = UserViewModel() as UserProvider
        @Provider var orderViewModel = OrderViewModel() as OrderProvider
        @Provider var productViewModel = ProductViewModel() as ProductProvider
        @Provider var signInEmailPasswordViewModel = SignInEmailPasswordViewModel() as SignInEmailPasswordProvider
        @Provider var signInGoogleViewModel = SignInWithGoogleViewModel() as SignInGoogleProvider
    }
}
