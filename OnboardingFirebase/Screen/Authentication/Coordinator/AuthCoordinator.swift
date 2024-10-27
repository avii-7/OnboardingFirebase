//
//  AuthCoordinator.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import SwiftUI

protocol AuthCoordinatorDelegate: Coordinator, AnyObject {
    
    func didSignUpFinished()
    
    func didSignInFinished()
}

final class AuthCoordinator {
    
    weak var delegate: AuthCoordinatorDelegate?
    
    private let dIContainer: AuthDIContainer
    
    init(dIContainer: AuthDIContainer) {
        self.dIContainer = dIContainer
    }
    
    func start() {
        let actions = SignInView.Actions(
            didSignInFinished: didSignInFinished,
            showSignUpView: showSignUpView,
            showForgotPasswordView: showForgotPasswordView)
        delegate?.push(Authentication.signIn(actions, dIContainer.getSignInViewModel()))
    }
    
    private func didSignInFinished() {
        delegate?.didSignInFinished()
    }
    
    private func showSignUpView() {
        delegate?.push(Authentication.signUp(.init(didSignUpFinished: didSignUpFinished), dIContainer.getSignUpViewModel()))
    }
    
    private func didSignUpFinished() {
        delegate?.didSignUpFinished()
    }
    
    private func showForgotPasswordView() {
        delegate?.push(Authentication.forgotPassword(dIContainer.getForgotPasswordViewModel()))
    }
}

extension AuthCoordinator {
    
    enum Authentication {
        
        case signIn(SignInView.Actions, SignInViewModel), signUp(SignUpView.Actions, SignUpViewModel)
        case forgotPassword(ForgotPasswordViewModel), emailSent
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .signIn(let actions, let viewModel):
                SignInView(actions: actions, viewModel: viewModel)
            case .signUp(let actions, let vm):
                SignUpView(actions: actions, viewModel: vm)
            case .forgotPassword(let vm):
                ForgotPasswordView(viewModel: vm)
            case .emailSent:
                EmailSentView()
            }
        }
    }
}
