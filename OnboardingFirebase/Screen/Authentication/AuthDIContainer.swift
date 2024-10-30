//
//  AuthDIContainer.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

final class AuthDIContainer {
    
    struct Dependencies {
        let userSession: UserSession
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var authentication: FirebaseAuthentication =  {
        let firebaseAuthentication = FirebaseAuthentication()
        return firebaseAuthentication
    }()
    
    // MARK: - Coordinator
    func getCoordinator() -> AuthCoordinator {
        AuthCoordinator(dIContainer: self)
    }
    
    // MARK: - SignUp
    func getSignUpService() -> SignUpService {
        authentication
    }
    
    func getSignUpViewModel(actions: SignUpViewModel.NavigationActions) -> SignUpViewModel {
        SignUpViewModel(service: getSignUpService(), userSession: dependencies.userSession, actions: actions)
    }
    
    // MARK: - SignIn
    func getSignInService() -> SignInService {
        authentication
    }
    
    func getSignInViewModel() -> SignInViewModel {
        SignInViewModel(signInService: getSignInService(), userSession: dependencies.userSession)
    }
    
    // MARK: - Forgot Password
    func getForgotPasswordService() -> ForgotPasswordService {
        authentication
    }
    
    func getForgotPasswordViewModel() -> ForgotPasswordViewModel {
        ForgotPasswordViewModel(forgotPasswordService: getForgotPasswordService())
    }
}
