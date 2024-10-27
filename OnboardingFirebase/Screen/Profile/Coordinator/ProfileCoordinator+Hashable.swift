//
//  ProfileCoordinator+Hashable.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import Foundation

extension ProfileCoordinator.Profile : Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: ProfileCoordinator.Profile, rhs: ProfileCoordinator.Profile) -> Bool {
        switch (lhs, rhs) {
        case (.profile, .profile): true
        default: false
        }
    }
}
