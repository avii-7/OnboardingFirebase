//
//  AppCompositionRoot.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import Foundation

enum AppCompositionRoot {
    
    static let userSession: UserSession = {
        let userSession = FirebaseUserSession()
        return userSession
    }()
}

extension AppCompositionRoot {
    
    enum Auth {
        static var authentication: Authentication {
            let firebaseAuthentication = FirebaseAuthentication()
            return firebaseAuthentication
        }
    }
}
