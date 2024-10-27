//
//  ForgotPasswordServiceStub.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

final class ForgotPasswordServiceStub: ForgotPasswordService {
    
    func forgotPassword(email: String) async throws {
        print("Forgot Password Clicked")
    }
}
