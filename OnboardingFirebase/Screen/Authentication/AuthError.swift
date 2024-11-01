//
//  AuthError.swift
//  OnboardingFirebase
//
//  Created by Arun on 01/11/24.
//

import Foundation

enum AuthError: Error, LocalizedError {
    case invalidCredentials
    case emailAlreadyInUse
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            "Invalid credentials"
        case .emailAlreadyInUse:
            "Email already in use"
        case .unknown(let message):
            message
        }
    }
}

extension AuthError: Equatable { }
