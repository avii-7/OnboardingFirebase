//
//  SignInViewModel.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

final class SignInViewModel: ObservableObject {
    
    @Published var isError = false
    @Published var errorMsg : String?
    @Published var isSignInCompleted: Bool = false
    @Published var isEmailSent = false
    
    private let signInService: SignInService
    
    private let userSession: UserSession
    
    init(signInService: SignInService, userSession: UserSession) {
        self.signInService = signInService
        self.userSession = userSession
    }
    
    @MainActor
    func signIn(email: String, password: String) async {
        do {
            let user = try await signInService.signIn(email: email, password: password)
            userSession.updateUser(user: user)
            isSignInCompleted = true
        }
        catch {
            isError = true
            errorMsg = error.localizedDescription
            print(error)
        }
    }
}
