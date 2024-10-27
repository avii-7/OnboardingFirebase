//
//  ProfileView.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .navigationBarBackButtonHidden()
            .onChange(of: viewModel.shouldDismiss, { oldValue, newValue in
                if newValue {
                    //router.didLogout()
                }
            })
            .task {
                await viewModel.fetchUser()
            }
    }
}

extension ProfileView {
    
    private var content: some View {
        VStack {
            if let user = viewModel.user {
                List {
                    Section {
                        accountDetails(using: user)
                    }
                    
                    Section("Account") {
                        accountSetting(using: user)
                    }
                }
            }
            else {
                ProgressView()
            }
        }
    }
    
    private func accountDetails(using user: User) ->  some View {
        HStack (spacing: 20) {
            Text(user.initials)
                .font(.headline)
                .foregroundStyle(.white)
                .padding()
                .background(Circle().fill(.gray))
            
            VStack(alignment: .leading) {
                Text(user.fullName)
                    .font(.subheadline)
                
                Text(user.email)
                    .font(.footnote)
            }
            .foregroundStyle(.black)
        }
    }
    
    private func accountSetting(using user: User) ->  some View {
        Group {
            
            // MARK: Sign Out
            Button {
                viewModel.logOut()
            } label: {
                Label {
                    Text("Sign Out")
                        .foregroundStyle(.black)
                } icon: {
                    Image(systemName: "arrow.left.circle.fill")
                        .foregroundStyle(.red)
                }
            }
            
            // MARK: Delete Account
            Button {
                Task {
                    await viewModel.deleteAccount()
                }
            } label: {
                Label {
                    Text("Delete Account")
                        .foregroundStyle(.black)
                } icon: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.red)
                }
                
            }
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(userSession: UserSessionStub()))
}
