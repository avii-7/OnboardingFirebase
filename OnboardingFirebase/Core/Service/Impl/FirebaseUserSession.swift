//
//  FirebaseUserSession.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import FirebaseAuth
import FirebaseFirestore

enum FirebaseUserSessionError: Error {
    case notLoggedIn
}

final class FirebaseUserSession: UserSession {
    
    var isUserLoggedIn: Bool { auth.currentUser != nil }
    
    var user: User?
    
    lazy private var auth = Auth.auth()
    
    lazy private var firestore = Firestore.firestore()
    
    // TODO: Should be done in profile
    // FIXME: - CurrentUser can contain my user information
    func fetchUser() async throws {
        if let firebaseUser = auth.currentUser {
            let document = try await firestore.collection("users").document(firebaseUser.uid).getDocument()
            user = try document.data(as: User.self)
        }
        else {
            throw FirebaseUserSessionError.notLoggedIn
        }
    }
    
    func updateUser(user: User) {
        self.user = user
    }
    
    func logOut() throws {
        try auth.signOut()
    }
    
    func deleteAccount() async throws {
        if let user = user {
            try await deleteUserFromFirestore(id: user.id)
        }
        
        try await auth.currentUser?.delete()
        user = nil
    }
    
    private func deleteUserFromFirestore(id uid: String) async throws {
       try await Firestore.firestore().collection("users").document(uid).delete()
    }
}
