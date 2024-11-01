//
//  ProfileViewModel.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    struct NavigationAction {
        let logOut: () -> Void
        let deleteAccount: () -> Void
    }
    
    @Published var user: User?
    
    private var userSession: UserSession
    
    private let navigationActions: NavigationAction
    
    init(navigationActions: NavigationAction, userSession: UserSession) {
        self.userSession = userSession
        self.navigationActions = navigationActions
    }
    
    @MainActor
    func fetchUser() async {
        do {
            try await userSession.fetchUser()
            user = userSession.user
        }
        catch {
            print(error)
        }
    }
    
    func logOut() {
        do {
            try userSession.logOut()
            userSession.user = nil
            navigationActions.logOut()
        }
        catch {
            print(error)
        }
    }
    
    @MainActor
    func deleteAccount() async {
        do {
            try await userSession.deleteAccount()
            userSession.user = nil
            navigationActions.deleteAccount()
        }
        catch {
            print(error)
        }
    }
}
