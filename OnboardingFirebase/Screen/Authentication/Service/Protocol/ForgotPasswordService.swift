//
//  ForgotPasswordService.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

protocol ForgotPasswordService {
    func forgotPassword(email: String) async throws
}
