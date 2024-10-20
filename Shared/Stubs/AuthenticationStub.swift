//
//  AuthenticationStub.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import Foundation

final class AuthenticationStub: Authentication {
    
    private let user = User(
        id: UUID().uuidString,
        email: "arunmehra1999@gmail.com",
        fullName: "Arun Mehra"
    )
    
    func signup(email: String, fullName: String, password: String) async throws -> User {
        user
    }
    
    func signIn(email: String, password: String) async throws -> User? {
        user
    }
}
