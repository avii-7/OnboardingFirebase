//
//  CapsuleBorderButtonStyle.swift
//  OnboardingFirebase
//
//  Created by Arun on 19/10/24.
//

import SwiftUI

struct CapsuleBorderButtonStyle: ButtonStyle {
    
    var borderColor: Color
    var fgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(fgColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().stroke(borderColor))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

#Preview {
    Button("Sign up") { }
        .buttonStyle(CapsuleBorderButtonStyle(borderColor: .black, fgColor: .black))
}
