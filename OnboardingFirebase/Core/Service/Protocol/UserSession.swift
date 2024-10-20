//
//  UserSession.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import Foundation

protocol UserSession {
    
    var isUserLoggedIn: Bool { get }
    
    var user: User? { get set }
    
    func fetchUser() async throws
    
    func updateUser(user: User)
    
    func logOut() throws
    
    func deleteAccount() async throws
}
