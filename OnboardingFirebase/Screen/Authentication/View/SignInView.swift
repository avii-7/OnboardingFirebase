//
//  SignInView.swift
//  OnboardingFirebase
//
//  Created by Arun on 19/10/24.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email = String.empty
    
    @State private var password = String.empty
    
    @StateObject private var viewModel: SignInViewModel
    
    private let actions: Actions
    
    init(actions: Actions, viewModel: SignInViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.actions = actions
    }
    
    var body: some View {
        content
            .navigationBarBackButtonHidden()
            .ignoresSafeArea(edges: .top)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .onChange(of: viewModel.isSignInCompleted) { _, newValue in
                if newValue {
                    actions.didSignInFinished()
                }
            }
    }
}

extension SignInView {
    
    private var content: some View {
        ScrollView {
            Group {
                headerImage
                manaulLogin
                spacer()
                signup
            }
        }.scrollIndicatorsFlash(onAppear: true)
    }
    
    private var headerImage: some View {
        Image(ImageIdentifier.Auth.loginImage)
            .resizable()
            .scaledToFit()
    }
    
    private var manaulLogin: some View {
        VStack {
            Text("Let's Connect With Us !")
                .font(.title2)
                .fontWeight(.semibold)
            
            spacer()
            
            BottomDividerView {
                TextField("Email or Phone number", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }
            
            BottomDividerView {
                SecureField("Password", text: $password)
                    .textContentType(.password)
            }
            
            HStack {
                Spacer()
                Button("Forgot Password ?") {
                    actions.showForgotPasswordView()
                }
                .foregroundStyle(.gray)
                .font(.subheadline)
            }
            .padding(.vertical)
            
            Button("SignIn") {
                Task {
                    await viewModel.signIn(email: email, password: password)
                }
            }
            .buttonStyle(
                CapsuleButtonStyle(
                    bgColor: .teal,
                    fgColor: .white
                )
            )
        }
    }
    
    private var signup: some View {
        VStack(spacing: 20) {
            
            hLineOrView
            
            signupAppleButton
            
            signupGoogleButton
            
            footer
        }
    }
    
    private var hLineOrView : some View  {
        HStack (spacing: 16) {
            HLine()
            Text("or")
                .fontWeight(.semibold)
            HLine()
        }
        .foregroundStyle(.gray)
    }
    
    private var signupAppleButton: some View {
        Button { }
        label: {
            Label("Sign up with Apple", systemImage: "apple.logo")
        }
        .buttonStyle(CapsuleButtonStyle(bgColor: .black, fgColor: .white))
    }
    
    private var signupGoogleButton: some View {
        Button { }
        label: {
            Label {
                Text("Sign up with Google")
            } icon: {
                Image(ImageIdentifier.Core.google)
                    .resizable()
                    .frame(width: 15, height: 15)
            }
        }
        .buttonStyle(CapsuleBorderButtonStyle(borderColor: .black, fgColor: .black))
    }
    
    private var footer: some View {
        Button {
            actions.showSignUpView()
        } label: {
            HStack {
                Text("Don't have an account ?")
                    .foregroundStyle(.black)
                Text("Sign up")
                    .foregroundStyle(.teal)
            }
            .fontWeight(.medium)
        }
    }
    
    private func spacer(spacing: CGFloat = 35) -> some View {
        Spacer().frame(height: spacing)
    }
}

// MARK: - Actions
extension SignInView {
    
    struct Actions {
        let didSignInFinished: () -> Void
        let showSignUpView: () -> Void
        let showForgotPasswordView: () -> Void
    }
}

#Preview {
    NavigationStack {
        SignInView(
            actions: .init(didSignInFinished: {}, showSignUpView: {}, showForgotPasswordView: {}),
            viewModel: SignInViewModel(
                signInService: SignInServiceStub(),
                userSession: UserSessionStub()
            )
        )
    }
}
