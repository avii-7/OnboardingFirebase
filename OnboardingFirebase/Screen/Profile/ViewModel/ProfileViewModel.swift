//
//  ProfileViewModel.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    @Published var user: User?
    
    @Published var shouldDismiss = false
    
    private var userSession: UserSession
    
    init(userSession: UserSession) {
        self.userSession = userSession
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
            shouldDismiss = true
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
            shouldDismiss = true
        }
        catch {
            print(error)
        }
    }
}
