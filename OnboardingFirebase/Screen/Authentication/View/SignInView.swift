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
    
    init(viewModel: SignInViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .navigationBarBackButtonHidden()
            .ignoresSafeArea(edges: .top)
            .padding(.horizontal)
            .padding(.vertical, 5)
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
                    viewModel.showForgotPasswordView()
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
            
            if viewModel.isError {
                Text(viewModel.errorMsg)
                    .font(.footnote)
                    .foregroundStyle(.red).opacity(0.8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
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
            viewModel.showSignUpView()
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

#Preview {
    NavigationStack {
        SignInView(
            viewModel: SignInViewModel(
                navigationAction: .init(didSignInFinished: {}, showSignUpView: {}, showForgotPasswordView: {}),
                signInService: SignInServiceStub(),
                userSession: UserSessionStub()
            )
        )
    }
}
