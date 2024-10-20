//
//  MainView.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import SwiftUI

struct MainView: View {
    
    private let userSession: UserSession
    
    private let authentication: Authentication
    
    @EnvironmentObject private var router: NavigationRouter
    
    init(userSession: UserSession, authentication: Authentication) {
        self.userSession = userSession
        self.authentication = authentication
    }
    
    var body: some View {
        VStack { }
            .onAppear {
                if userSession.isUserLoggedIn {
                    router.push(NavigationIdentifier.Profile.profile)
                }
                else {
                    router.push(NavigationIdentifier.Authentication.signIn(viewModel: AuthViewModel(authentication: authentication, userSession: userSession)))
                }
            }
    }
}

#Preview {
    MainView(userSession: UserSessionStub(), authentication: AuthenticationStub())
}
