//
//  ProfileDIContainer.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

final class ProfileDIContainer {
    
    struct Dependencies {
        let userSession: UserSession
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getProfileViewModel(navigationActions: ProfileViewModel.NavigationAction) -> ProfileViewModel {
        ProfileViewModel(navigationActions: navigationActions, userSession: dependencies.userSession)
    }
    
    // MARK: - Coordinator
    func getCoordinator() -> ProfileCoordinator {
        ProfileCoordinator(dIContainer: self)
    }
}
