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
    
    init(service: SignUpService, userSession: UserSession) {
        self.service = service
        self.userSession = userSession
    }
    
    // FIXME: - Precise Errors
    func signUp(email: String, fullName: String, password: String) async {
        do {
            let user = try await service.signUp(email: email, fullName: fullName, password: password)
            userSession.updateUser(user: user)
        }
        catch {
            isError = true
            errorMsg = error.localizedDescription
            print(error)
        }
    }
}
