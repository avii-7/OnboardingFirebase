//
//  AppDIContainer.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

final class AppDIContainer {
    
    lazy var userSession: UserSession = {
        let userSession = FirebaseUserSession()
        return userSession
    }()
    
    func makeAuthDIContainer() -> AuthDIContainer {
        AuthDIContainer(dependencies: .init(userSession: userSession))
    }
    
    func makeProfileDIContainer() -> ProfileDIContainer {
        ProfileDIContainer(dependencies: .init(userSession: userSession))
    }
}
