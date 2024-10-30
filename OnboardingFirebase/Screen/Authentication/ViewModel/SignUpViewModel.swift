//
//  SignUpViewModel.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    
    @Published var isError = false
    @Published var errorMsg : String?
    
    private let service: SignUpService
    private let userSession: UserSession
    private let actions: NavigationActions
    
    init(service: SignUpService, userSession: UserSession, actions: NavigationActions) {
        self.service = service
        self.userSession = userSession
        self.actions = actions
    }
    
    // FIXME: - Precise Errors should be thrown by service layer.
    @MainActor
    func signUp(email: String, fullName: String, password: String) async {
        do {
            let user = try await service.signUp(email: email, fullName: fullName, password: password)
            userSession.updateUser(user: user)
            actions.didSignUpFinished()
        }
        catch {
            isError = true
            errorMsg = error.localizedDescription
            print(error)
        }
    }
}

// MARK: - Actions
extension SignUpViewModel {
    
    struct NavigationActions {
        let didSignUpFinished: () -> Void
    }
}
