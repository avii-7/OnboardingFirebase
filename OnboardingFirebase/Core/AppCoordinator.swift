//
//  AppCoordinator.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import SwiftUI

protocol Coordinator {
    
    func push(_ identifier: some Hashable)
    
    func pop()
    
    func popToRoot()
}

final class AppCoordinator: Coordinator, ObservableObject {
    
    @Published var path: NavigationPath
    
    private let dIContainer: AppDIContainer
    
    init(path: NavigationPath, dIContainer: AppDIContainer) {
        self.path = path
        self.dIContainer = dIContainer
    }
    
    func start() {
        if dIContainer.userSession.isUserLoggedIn {
            navigateToProfile()
        }
        else {
            navigateToAuthentication()
        }
    }
    
    func push(_ identifier: some Hashable) {
        path.append(identifier)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func didLogout() {
        path.removeLast(path.count)
    }
    
    func navigateToAuthentication() {
        let authDIContainer = dIContainer.makeAuthDIContainer()
        let flow = authDIContainer.getCoordinator()
        flow.delegate = self
        flow.start()
    }
    
    func navigateToProfile() {
        let profileDIContainer = dIContainer.makeProfileDIContainer()
        let flow = profileDIContainer.getCoordinator()
        flow.delegate = self
        flow.start()
    }
}

// MARK: - Auth Coordinator Delegate
extension AppCoordinator: AuthCoordinatorDelegate {
    
    func popToAuthentication() {
        path.removeLast(path.count - 1)
    }
    
    func didSignUpFinished() {
        popToRoot()
        navigateToProfile()
    }
    
    func didSignInFinished() {
        popToRoot()
        navigateToProfile()
    }
}

// MARK: - Profile Coordinator
extension AppCoordinator : ProfileCoordinatorDelegate {
    
    func didTapLogout() {
        popToRoot()
        navigateToAuthentication()
    }
    
    func didTapDeleteAccount() {
        popToRoot()
        navigateToAuthentication()
    }
}
