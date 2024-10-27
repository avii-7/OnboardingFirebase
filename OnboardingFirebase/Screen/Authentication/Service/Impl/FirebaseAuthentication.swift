//
//  FirebaseAuthentication.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class FirebaseAuthentication {
    
    lazy private var auth = Auth.auth()
    
    lazy private var firestore = Firestore.firestore()
    
    private func createUserInFirestore(uuid: String, email: String, fullName: String) throws {
        let user = User(id: uuid, email: email, fullName: fullName)
        try firestore.collection("users").document(uuid).setData(from: user)
    }
}

// MARK: - SignUp Service
extension FirebaseAuthentication: SignUpService {
    
    func signUp(email: String, fullName: String, password: String) async throws -> User {
        let result = try await auth.createUser(withEmail: email, password: password)
        try createUserInFirestore(uuid: result.user.uid, email: email, fullName: fullName)
        let user = User(id: result.user.uid, email: email, fullName: fullName)
        return user
    }
}

// MARK: - SignIn Service
extension FirebaseAuthentication: SignInService {
    
    func signIn(email: String, password: String) async throws -> User {
        let result = try await auth.signIn(withEmail: email, password: password)
        let authUser = result.user
        let user = try await firestore.collection("users").document(authUser.uid).getDocument()
        return try user.data(as: User.self)
    }
}

// MARK: - Forgot Password Service
extension FirebaseAuthentication: ForgotPasswordService {
    
    func forgotPassword(email: String) async throws {
        try await auth.sendPasswordReset(withEmail: email)
    }
}
