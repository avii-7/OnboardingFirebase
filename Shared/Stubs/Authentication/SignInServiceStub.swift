//
//  SignInServiceStub.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

final class SignInServiceStub: SignInService {
    
    func signIn(email: String, password: String) async throws -> User {
        .dummy
    }
    
    func forgotPassword(email: String) async throws {
        print("forgot password clicked")
    }
}
