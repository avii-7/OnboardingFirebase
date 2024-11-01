//
//  ForgotPasswordViewModel.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

final class ForgotPasswordViewModel: ObservableObject {
    
    struct NavigationAction {
        let didTapForgotPassword: () -> Void
    }
    
    private let forgotPasswordService: ForgotPasswordService
    
    private let navigationActions: NavigationAction
    
    init(navigationActions: NavigationAction, forgotPasswordService: ForgotPasswordService) {
        self.forgotPasswordService = forgotPasswordService
        self.navigationActions = navigationActions
    }
    
    @MainActor
    func forgotPassword(email: String) async {
        do {
            try await forgotPasswordService.forgotPassword(email: email)
            navigationActions.didTapForgotPassword()
        }
        catch {
            print(error)
        }
    }
}
