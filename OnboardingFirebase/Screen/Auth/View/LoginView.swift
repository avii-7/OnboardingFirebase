//
//  LoginView.swift
//  OnboardingFirebase
//
//  Created by Arun on 19/10/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = String.empty
    
    @State private var password = String.empty
    
    var body: some View {
        content
            .ignoresSafeArea(edges: .top)
            .padding(.horizontal)
            .padding(.vertical, 5)
    }
}

extension LoginView {
    
    private var content: some View {
        ScrollView {
            Group {
                headerImage
                manaulLogin
                spacer()
                signup
            }
        }
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
            }
            
            BottomDividerView {
                SecureField("Password", text: $password)
            }
            
            HStack {
                Spacer()
                Button("Forgot Password ?") { }
                    .foregroundStyle(.gray)
                    .font(.subheadline)
            }
            .padding(.vertical)
            
            Button("Login") { }
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
        NavigationLink {
            CreateAccountView()
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
        LoginView()
    }
}
