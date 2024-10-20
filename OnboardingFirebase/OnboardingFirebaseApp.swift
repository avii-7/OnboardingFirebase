//
//  OnboardingFirebaseApp.swift
//  OnboardingFirebase
//
//  Created by Arun on 19/10/24.
//

import SwiftUI

@main
struct OnboardingFirebaseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var isCompleted = false
    
    private let userSession = AppCompositionRoot.userSession
    private let authentication = AppCompositionRoot.Auth.authentication
    
    @StateObject private var router = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            if isCompleted {
                NavigationStack(path: $router.path) {
                    MainView(userSession: userSession, authentication: authentication)
                        .navigationDestination(for: NavigationIdentifier.Authentication.self, destination: { item in
                            item.view
                        })
                        .navigationDestination(for: NavigationIdentifier.Profile.self, destination: { item in
                            item.view
                        })
                }
                .environmentObject(router)
            }
            else {
                SplashScreen(isCompleted: $isCompleted, userSession: userSession)
            }
        }
    }
}
