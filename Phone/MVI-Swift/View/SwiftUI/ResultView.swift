//
//  ResultView.swift
//  Phone
//
//  Created by KudzaisheMhou on 02/11/2023.
//

import SwiftUI
import Lottie

struct ResultView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            
            VStack(spacing: 16) {
                LottieView(animation: .named("success"))
                    .playing()
                    .frame(width: 180, height: 180)
                
                Text("Success")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est leo, vehicula eu eleifend non, auctor ut arcu, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est leo, vehicula eu eleifend non, auctor ut arcu")
                    .font(.system(size: 14, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 40)
                    .fixedSize(horizontal: false, vertical: true)
                
                
            }
            .padding(.top, 32)
            
            Spacer()
            
            Button(action: {
                userViewModel.viewState.homeId = UUID()
            }) {
                Text("Done")
                    .foregroundColor(.white)
                    .font(.body)
                    .frame(width: 180, height: 40)
            }
            .background(Color.blue)
            .cornerRadius(4)
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    ResultView()
}
