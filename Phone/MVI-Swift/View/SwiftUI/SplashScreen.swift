//
//  SplashScreen.swift
//  Phone
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import SwiftUI

struct SplashScreen: View {
    @State private var animateCards = false
    
    @Binding private var isActive: ViewType
    
    init(isActive: Binding<ViewType>) {
        self._isActive = isActive
    }

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            
            // UIKit Button
            StickyNoteButton(label: "UIKit", color: .gray) {
                isActive = .uiKit
            }
            .offset(x: animateCards ? -50 : -UIScreen.main.bounds.width/2, y: animateCards ? -150 : -UIScreen.main.bounds.height/2)
            .rotationEffect(.degrees(animateCards ? 0 : -30))

            // SwiftUI Button
            StickyNoteButton(label: "SwiftUI", color: Color.teal) {
                isActive = .swiftUI
            }
            .offset(x: animateCards ? 50 : UIScreen.main.bounds.width/2, y: animateCards ? -50 : -UIScreen.main.bounds.height/2)
            .rotationEffect(.degrees(animateCards ? 0 : 30))

            // Objective-C Button
            StickyNoteButton(label: "Objective-C", color: .gray) {
                isActive = .objectiveC
            }
            .offset(y: animateCards ? 150 : UIScreen.main.bounds.height/2)
            .rotationEffect(.degrees(animateCards ? 0 : -15))
        }
        .onAppear {
            withAnimation(Animation.easeOut(duration: 1)) {
                animateCards = true
            }
        }
    }
}

struct StickyNoteButton: View {
    var label: String
    var color: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .foregroundColor(.white)
                .frame(width: 140, height: 140)
                .background(color)
                .cornerRadius(8)
                .shadow(radius: 10)
        }
    }
}

#Preview {
    SplashScreen(isActive: .constant(.swiftUI))
}
