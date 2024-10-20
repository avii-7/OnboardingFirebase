//
//  User.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import Foundation

struct User : Codable {
    let id: String
    let email: String
    let fullName: String
}

extension User {
    
    var initials: String {
        let nameFormatter = PersonNameComponentsFormatter()
        if let components = nameFormatter.personNameComponents(from: self.fullName) {
            nameFormatter.style = .abbreviated
            return nameFormatter.string(from: components)
        }
        
        return .empty
    }
}

extension User: Equatable { }
