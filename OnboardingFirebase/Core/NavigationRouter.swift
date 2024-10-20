//
//  NavigationRouter.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import SwiftUI

class NavigationRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func push(_ identifier: some Hashable) {
        path.append(identifier)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func didAuthenticationFinish() {
        path.removeLast(path.count)
        push(NavigationIdentifier.Profile.profile)
    }
    
    func didLogout() {
        path.removeLast(path.count)
    }
}

enum NavigationIdentifier {
    
    enum Authentication {
        
        case signIn(viewModel: AuthViewModel), signUp(viewModel: AuthViewModel)
        case forgotPassword, emailSent
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .signIn(let viewModel):
                LoginView(viewModel: viewModel)
            case .signUp(let viewModel):
                CreateAccountView(viewModel: viewModel)
            case .forgotPassword:
                ForgotPasswordView()
            case .emailSent:
                EmailSentView()
            }
        }
    }
    
    enum Profile {
        case profile
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .profile:
                ProfileView(viewModel: ProfileViewModel(userSession: AppCompositionRoot.userSession))
            }
        }
    }
}

// MARK: - Hashable Implementation

extension NavigationIdentifier.Authentication : Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: NavigationIdentifier.Authentication, rhs: NavigationIdentifier.Authentication) -> Bool {
        switch (lhs, rhs) {
        case(.signIn, .signIn):
            return true
        case (.signUp, .signUp):
            return true
        case (.forgotPassword, .forgotPassword):
            return true
        case (.emailSent, .emailSent):
            return true
        default:
            return false
        }
    }
}

extension NavigationIdentifier.Profile : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}
