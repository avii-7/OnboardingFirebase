//
//  SignUpServiceStub.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

final class SignUpServiceStub: SignUpService {
    
    func signUp(email: String, fullName: String, password: String) async throws -> User {
        .dummy
    }
}
