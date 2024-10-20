//
//  UserSessionStub.swift
//  OnboardingFirebaseTests
//
//  Created by Arun on 20/10/24.
//

import Foundation

final class UserSessionStub: UserSession {
    
    var isUserLoggedIn: Bool { user != nil }
    
    var user: User?
    
    func fetchUser() async throws {
        user = User(id: UUID().uuidString, email: "arunmehra1999@gmail.com", fullName: "Arun Mehra")
        print("User Fetched !")
    }
    
    func updateUser(user: User) {
        self.user = user
    }
    
    func logOut() throws {
        user = nil
    }
    
    func deleteAccount() async throws {
        user = nil
    }
}
