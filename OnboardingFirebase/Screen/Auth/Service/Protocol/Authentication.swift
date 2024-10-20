//
//  Authentication.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import Foundation

protocol Authentication {
    func signup(email: String, fullName: String, password: String) async throws -> User
    
    func signIn(email: String, password: String) async throws -> User?
}
