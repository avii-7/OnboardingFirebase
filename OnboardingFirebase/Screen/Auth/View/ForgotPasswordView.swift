//
//  ForgotPasswordView.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @EnvironmentObject private var router: NavigationRouter
    
    @State private var email: String = .empty
    
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
                router.push(NavigationIdentifier.Authentication.emailSent)
                email = .empty
            }
            .buttonStyle(CapsuleButtonStyle(bgColor: .teal, fgColor: .white))
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .toolbarRole(.editor)
    }
}

#Preview {
    ForgotPasswordView()
}
