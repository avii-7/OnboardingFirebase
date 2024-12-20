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
    
    func popToAuthentication()
}

final class AuthCoordinator {
    
    weak var delegate: AuthCoordinatorDelegate?
    
    private let dIContainer: AuthDIContainer
    
    init(dIContainer: AuthDIContainer) {
        self.dIContainer = dIContainer
    }
    
    func start() {
        let navigationAction = SignInViewModel.NavigationAction(
            didSignInFinished: didSignInFinished,
            showSignUpView: showSignUpView,
            showForgotPasswordView: showForgotPasswordView)
        delegate?.push(Authentication.signIn(dIContainer.getSignInViewModel(actions: navigationAction)))
    }
    
    private func didSignInFinished() {
        delegate?.didSignInFinished()
    }
    
    private func showSignUpView() {
        delegate?.push(Authentication.signUp(dIContainer.getSignUpViewModel(actions: .init(didSignUpFinished: didSignUpFinished))))
    }
    
    private func didSignUpFinished() {
        delegate?.didSignUpFinished()
    }
    
    private func showForgotPasswordView() {
        delegate?.push(Authentication.forgotPassword(dIContainer.getForgotPasswordViewModel(navigationActions: .init(didTapForgotPassword: didTapForgotPassword))))
    }
    
    private func didTapForgotPassword() {
        delegate?.push(Authentication.emailSent(.init(didTapSkipButton: didTapSkipButton, didTapTryAnotherEmail: didTapAnotherEmail)))
    }
    
    private func didTapSkipButton() {
        delegate?.popToAuthentication()
    }
    
    private func didTapAnotherEmail() {
        delegate?.pop()
    }
}

extension AuthCoordinator {
    
    enum Authentication {
        
        case signIn(SignInViewModel), signUp(SignUpViewModel)
        case forgotPassword(ForgotPasswordViewModel), emailSent(EmailSentView.NavigationActions)
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .signIn(let viewModel):
                SignInView(viewModel: viewModel)
            case .signUp(let vm):
                SignUpView(viewModel: vm)
            case .forgotPassword(let vm):
                ForgotPasswordView(viewModel: vm)
            case .emailSent(let navActions):
                EmailSentView(navigationActions: navActions)
            }
        }
    }
}
