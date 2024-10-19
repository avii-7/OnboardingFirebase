//
//  CapsuleButtonStyle.swift
//  OnboardingFirebase
//
//  Created by Arun on 19/10/24.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    
    var bgColor: Color
    var fgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(fgColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(bgColor))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

#Preview {
    Button("Sign up") { }
        .buttonStyle(CapsuleButtonStyle(bgColor: .clear, fgColor: .black))
}
