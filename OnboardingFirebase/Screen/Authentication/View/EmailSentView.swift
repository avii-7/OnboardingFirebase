//
//  EmailSentView.swift
//  OnboardingFirebase
//
//  Created by Arun on 20/10/24.
//

import SwiftUI

struct EmailSentView: View {
    
    struct NavigationActions {
        let didTapSkipButton: () -> Void
        let didTapTryAnotherEmail: () -> Void
    }
    
    private let navigationActions: NavigationActions
    
    init(navigationActions: NavigationActions) {
        self.navigationActions = navigationActions
    }
    
    var body: some View {
        VStack (spacing: 24) {
            Spacer()
            Image(systemName: "envelope.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .scaledToFit()
                .foregroundStyle(.teal)
            
            VStack (spacing: 8) {
                Text("Check your email")
                    .font(.largeTitle.bold())
                
                Text("We have sent a password recover instructions to your email.")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            
            Button("Skip I'll confirm later") {
                navigationActions.didTapSkipButton()
            }
            .buttonStyle(CapsuleButtonStyle(bgColor: .teal, fgColor: .white))
            
            Spacer()
            
            Button {
                navigationActions.didTapTryAnotherEmail()
            } label: {
                Text("Didn't receive the email? Check your spam filter, or ")
                    .foregroundStyle(.gray)
                +
                Text("try another email address")
                    .foregroundStyle(.teal)
                
            }
        }
        .padding(.horizontal)
        .toolbarRole(.editor)
    }
}

#Preview {
    EmailSentView(navigationActions: .init(didTapSkipButton: {
        print("Skip button pressed")
    }, didTapTryAnotherEmail: {
        print("Another email button pressed")
    }))
}
