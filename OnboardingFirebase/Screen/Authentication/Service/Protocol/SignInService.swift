//
//  SignInService.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

protocol SignInService {
    
    func signIn(email: String, password: String) async throws -> User
}
