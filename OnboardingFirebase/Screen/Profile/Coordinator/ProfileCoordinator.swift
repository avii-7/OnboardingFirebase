//
//  ProfileCoordinator.swift
//  OnboardingFirebase
//
//  Created by Arun on 27/10/24.
//

import SwiftUI

protocol ProfileCoordinatorDelegate: Coordinator, AnyObject {
    
    func didTapLogout()
    
    func didTapDeleteAccount()
}

final class ProfileCoordinator {
    
    weak var delegate: ProfileCoordinatorDelegate?
    
    private let dIContainer: ProfileDIContainer
    
    init(dIContainer: ProfileDIContainer) {
        self.dIContainer = dIContainer
    }
    
    func start() {
        delegate?.push(Profile.profile(dIContainer.getProfileViewModel(navigationActions: .init(logOut: didTapLogout, deleteAccount: didTapDeleteAccount))))
    }
    
    private func didTapLogout() {
        delegate?.didTapLogout()
    }
    
    private func didTapDeleteAccount() {
        delegate?.didTapDeleteAccount()
    }
}

extension ProfileCoordinator {
    
    enum Profile {
        case profile(ProfileViewModel)
        
        var view: some View {
            switch self {
            case .profile(let vm):
                ProfileView(viewModel: vm)
            }
        }
    }
}
