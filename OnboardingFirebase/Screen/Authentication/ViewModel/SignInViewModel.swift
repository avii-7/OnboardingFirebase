//
//  SignInViewModel.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

final class SignInViewModel: ObservableObject {
    
    struct NavigationAction {
        let didSignInFinished: () -> Void
        let showSignUpView: () -> Void
        let showForgotPasswordView: () -> Void
    }
    
    @Published var isError = false
    private(set) var errorMsg : String = .empty
    @Published var isEmailSent = false
    
    private let signInService: SignInService
    
    private let userSession: UserSession
    
    private let navigationAction: NavigationAction
    
    init(navigationAction: NavigationAction, signInService: SignInService, userSession: UserSession) {
        self.signInService = signInService
        self.userSession = userSession
        self.navigationAction = navigationAction
    }
    
    @MainActor
    func signIn(email: String, password: String) async {
        let result = await signInService.signIn(email: email, password: password)
        switch result {
        case .success(let user):
            userSession.updateUser(user: user)
            navigationAction.didSignInFinished()
        case .failure(let error):
            if error == AuthError.invalidCredentials {
                isError = true
                errorMsg = error.localizedDescription
            }
        }
    }
    
    func showSignUpView() {
        navigationAction.showSignUpView()
    }
    
    func showForgotPasswordView() {
        navigationAction.showForgotPasswordView()
    }
}
