//
//  SplashScreen.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import SwiftUI

struct SplashScreen: View {
    
    @Binding var isCompleted: Bool
    
    private let userSession: UserSession
    
    init(isCompleted: Binding<Bool>, userSession: UserSession) {
        self._isCompleted = isCompleted
        self.userSession = userSession
    }
    
    var body: some View {
        VStack {
            Text("Splash Screen")
        }
        .task {
            await fetchUser()
        }
    }
}

extension SplashScreen {
    
    @MainActor
    private func fetchUser() async {
        do {
            try await userSession.fetchUser()
        }
        catch {
            print(error)
        }
        isCompleted = true
    }
}

#Preview {
    SplashScreen(isCompleted: .constant(false), userSession: UserSessionStub())
}
