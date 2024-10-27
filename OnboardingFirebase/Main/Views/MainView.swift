//
//  MainView.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        VStack { }
            .onAppear {
                coordinator.start()
            }
    }
}

#Preview {
    MainView()
}
