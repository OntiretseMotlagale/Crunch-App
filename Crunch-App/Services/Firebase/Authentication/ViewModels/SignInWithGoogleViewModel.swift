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

protocol SignInGoogleProvider {
    func signWithGoogle() async throws
}

class SignInWithGoogleViewModel: SignInGoogleProvider {
    @Inject var userProvider: UserProvider
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
        
        let tokens = GoogleAuthProvidertModel(idToken: idToken, accessToken: accessToken)
        
        try await signInGoogle(tokens: tokens)
    }
    
    @discardableResult
    func signInGoogle(tokens: GoogleAuthProvidertModel) async throws -> AuthResultModel {
        let credentials = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signInAuth(credential: credentials)
    }
    
    func signInAuth(credential: AuthCredential) async throws -> AuthResultModel {
        let authResult = try await Auth.auth().signIn(with: credential)
        let newUser = DatabaseUser(uid: authResult.user.uid, fullname: authResult.user.displayName, email: authResult.user.email, orders: [])
        try await userProvider.uploadUserToDatabase(user: newUser)
        return AuthResultModel(user: authResult.user)
    }
}
