//
//  AuthCoordinator+Hashable.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

extension AuthCoordinator.Authentication : Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: AuthCoordinator.Authentication, rhs: AuthCoordinator.Authentication) -> Bool {
        switch (lhs, rhs) {
        case (.signIn, .signIn):
            true
        case (.signUp, .signUp):
            true
        case (.emailSent, .emailSent):
            true
        case (.forgotPassword, .forgotPassword):
            true
        default:
            false
        }
    }
}
