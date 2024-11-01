//
//  ForgotPasswordView.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email: String = .empty
    
    @ObservedObject private var viewModel: ForgotPasswordViewModel
    
    init(viewModel: ForgotPasswordViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Reset Password")
                .font(.largeTitle)
            
            Text("Enter the email associated with your account and we'll send an email with instructions to reset your password")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top, 8)
            
            BottomDividerView {
                TextField("Enter your email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            .padding(.top, 15)
            
            Button("Send Instructions") {
                Task {
                    await viewModel.forgotPassword(email: email)
                }
            }
            .buttonStyle(CapsuleButtonStyle(bgColor: .teal, fgColor: .white))
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .toolbarRole(.editor)
    }
}

//#Preview {
//    ForgotPasswordView(viewModel: ForgotPasswordViewModel(forgotPasswordService: ForgotPasswordServiceStub()))
//}
