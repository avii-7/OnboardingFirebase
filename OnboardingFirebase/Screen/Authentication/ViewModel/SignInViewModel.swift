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
    @Published var errorMsg : String?
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
        do {
            let user = try await signInService.signIn(email: email, password: password)
            userSession.updateUser(user: user)
            navigationAction.didSignInFinished()
        }
        catch {
            isError = true
            errorMsg = error.localizedDescription
            print(error)
        }
    }
    
    func showSignUpView() {
        navigationAction.showSignUpView()
    }
    
    func showForgotPasswordView() {
        navigationAction.showForgotPasswordView()
    }
}
