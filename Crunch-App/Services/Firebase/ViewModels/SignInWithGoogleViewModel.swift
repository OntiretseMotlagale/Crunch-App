//
//  SignInWithGoogleViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/07/22.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct GoogleAuthResultModel {
    let idToken: String
    let accessToken: String
}

protocol SignInGoogleProvider {
    func getProviders() throws -> [AuthProviderOptions]
    func signWithGoogle() async throws
}
class SignInWithGoogleViewModel: SignInGoogleProvider {
    
    func getProviders() throws -> [AuthProviderOptions] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badURL)
        }
        var providers: [AuthProviderOptions] = []
        for provider in providerData {
            print(provider)
            if let options = AuthProviderOptions(rawValue: provider.providerID) {
             
                providers.append(options)
            }
            else {
                print("Provider is not found\(provider.providerID)")
            }
        }
        return providers
    }
    @discardableResult
    func signInGoogle(tokens: GoogleAuthResultModel) async throws -> AuthResultModel {
        let credentials = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credentials)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthResultModel {
        let authResult = try await Auth.auth().signIn(with: credential)
        return AuthResultModel(user: authResult.user)
    }
    
    @MainActor
    func signWithGoogle() async throws {
        guard let topVC =  Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let GIDSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        guard let idToken = GIDSignInResult.user.idToken?.tokenString else {
            return
        }
        let accessToken = GIDSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleAuthResultModel(idToken: idToken, accessToken: accessToken)
        
        try await signInGoogle(tokens: tokens)
    }
}
