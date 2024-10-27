//
//  SignUpView.swift
//  OnboardingFirebase
//
//  Created by Arun on 19/10/24.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email: String = .empty
    
    @State private var fullName: String = .empty
    
    @State private var password: String = .empty
    
    @State private var confirmPassword: String = .empty
    
    @StateObject private var viewModel: SignUpViewModel
    
    @Environment(\.dismiss) var dismiss
    
    init(actions: Actions, viewModel: SignUpViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("Please complete all information to create account")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            
            VStack(spacing: 15) {
                BottomDividerView {
                    TextField("Email or Phone number", text: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                
                BottomDividerView {
                    TextField("Full name", text: $fullName )
                        .keyboardType(.namePhonePad)
                        .textContentType(.name)
                }
                
                BottomDividerView {
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                }
                
                BottomDividerView {
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textContentType(.password)
                        .overlay(alignment: .trailing) {
                            if password.isEmpty == false, confirmPassword.isEmpty == false {
                                Image(systemName: isValidPassword ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(isValidPassword ? .green : .red)
                            }
                        }
                }
            }
            
            Spacer()
            
            Button("Create Account") {
                Task {
                    await createUser()
                }
            }
            .buttonStyle(CapsuleButtonStyle(bgColor: .teal, fgColor: .white))
        }
        .padding(.horizontal)
        .navigationTitle("Set up your account")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
    
    private var isValidPassword: Bool {
        password == confirmPassword
    }
}

extension SignUpView {
    
    @MainActor func createUser() async {
        await viewModel.signUp(email: email, fullName: fullName, password: password)
        dismiss()
    }
}

// MARK: - Actions
extension SignUpView {
    
    struct Actions {
        let didSignUpFinished: () -> Void
    }
}

#Preview {
    NavigationStack {
        SignUpView(
            actions: .init(didSignUpFinished: { }),
            viewModel: SignUpViewModel(service: SignUpServiceStub(), userSession: UserSessionStub())
        )
    }
}
