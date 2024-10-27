//
//  ForgotPasswordViewModel.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

final class ForgotPasswordViewModel: ObservableObject {
    
    @Published var isEmailSent = false
    
    private let forgotPasswordService: ForgotPasswordService
    
    init(forgotPasswordService: ForgotPasswordService) {
        self.forgotPasswordService = forgotPasswordService
    }
    
    @MainActor
    func forgotPassword(email: String) async {
        do {
            try await forgotPasswordService.forgotPassword(email: email)
            isEmailSent = true
        }
        catch {
            print(error)
        }
    }
}
