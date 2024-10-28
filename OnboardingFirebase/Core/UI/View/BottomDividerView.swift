//
//  BottomDividerView.swift
//  OnboardingFirebase
//
//  Created by Arun on 19/10/24.
//

import SwiftUI

struct BottomDividerView<Content: View>: View {
    
    let spacing: CGFloat = 15
    
    private let injectedView: Content
    
    init(@ViewBuilder injectedView: () -> Content) {
        self.injectedView = injectedView()
    }
    
    var body: some View {
        VStack(spacing: 15) {
            injectedView
            Divider()
        }
    }
}

#Preview {
    BottomDividerView {
        Text("Nice to see you")
    }
}
