//
//  ColorsView.swift
//  Phone
//
//  Created by KudzaisheMhou on 02/11/2023.
//

import SwiftUI

struct ColorsView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false ) {
            LazyVStack(spacing: 0) {
                ForEach(userViewModel.viewState.colorsData, id: \.self) { color in
                    CardView(
                        showTitle: false,
                        showChevron: false,
                        showCircle: true,
                        circleColor: color.color ?? "",
                        infoArray: [color.name ?? ""]
                    )
                    .onTapGesture {
                        userViewModel.intent(.selectedColor(color))
                        userViewModel.viewState.showColorsView = false
                    }
                }
            }
        }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Select Preffered Color")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    userViewModel.viewState.showColorsView = false
                }) {
                    Label("", systemImage: "chevron.left")
                }
                .tint(.white)
            }
        }
    }
}

#Preview {
    ColorsView()
}
