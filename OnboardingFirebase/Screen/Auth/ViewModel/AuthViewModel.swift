//
//  AuthViewModel.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import Foundation

final class AuthViewModel: ObservableObject {
    
    private let authentication: Authentication
    
    private let userSession: UserSession
    
    @Published var isError = false
    @Published var errorMsg : String?
    @Published var isLoginComplete: Bool = false
    
    init(authentication: Authentication, userSession: UserSession) {
        self.authentication = authentication
        self.userSession = userSession
    }
    
    @MainActor
    func createUser(email: String, fullName: String, password: String) async {
        do {
            let user = try await authentication.signup(email: email, fullName: fullName, password: password)
            userSession.updateUser(user: user)
        }
        catch {
            isError = true
            errorMsg = error.localizedDescription
            print(error)
        }
    }
    
    @MainActor
    func logIn(email: String, password: String) async {
        do {
            if let user = try await authentication.signIn(email: email, password: password) {
                userSession.updateUser(user: user)
                isLoginComplete = true
            }
        }
        catch {
            isError = true
            errorMsg = error.localizedDescription
            print(error)
        }
    }
}
