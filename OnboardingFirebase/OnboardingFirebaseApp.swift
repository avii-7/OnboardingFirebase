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
    
    @StateObject private var appCoordinator = AppCoordinator(path: NavigationPath(), dIContainer: AppDIContainer())
    
    @StateObject private var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.path) {
                VStack { }.onAppear { appCoordinator.start() }
                    .navigationDestination(for: AuthCoordinator.Authentication.self, destination: { item in
                        item.view
                    })
                    .navigationDestination(for: ProfileCoordinator.Profile.self, destination: { item in
                        item.view
                    })
            }
            .environmentObject(networkMonitor)
        }
    }
}

/**
 if isCompleted {
 NavigationStack(path: $appCoordinator.path) {
 appCoordinator.getRootView()
 .navigationDestination(for: NavigationIdentifier.Authentication.self, destination: { item in
 item.view
 })
 .navigationDestination(for: NavigationIdentifier.Profile.self, destination: { item in
 item.view
 })
 }
 .environmentObject(appCoordinator)
 }
 else {
 SplashScreen(isCompleted: $isCompleted, userSession: appCoordinator)
 }
 */
