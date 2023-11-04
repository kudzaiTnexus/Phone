//
//  InfoView.swift
//  Phone
//
//  Created by KudzaisheMhou on 02/11/2023.
//

import SwiftUI

struct InfoView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var selectedColor: ColorData? {
        userViewModel.viewState.selectedColor ?? 
        userViewModel.viewState.colorsData.first
    }
    
    var body: some View {
        VStack {
            
            VStack {
                Text("Choose Gender")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black)
                
                Picker("Choose Gender", selection: $userViewModel.viewState.selectedGender) {
                    Text("Male").tag(0)
                    Text("Female").tag(1)
                    Text("Other").tag(2)
                }
                .pickerStyle(.segmented)
            }
            .padding(.top, 60)
            .frame(width: UIScreen.main.bounds.width/1.5)
            
            CardView(
                showTitle: true,
                showChevron: true,
                showCircle: true,
                title: "Select Employee preffered color",
                circleColor: selectedColor?.color ?? "",
                infoArray: [selectedColor?.name ?? ""]
            )
            .padding(.top, 60)
            .onTapGesture {
                userViewModel.viewState.showColorsView = true
            }
            
            TextField("Residential Address...", text: $userViewModel.viewState.residentialAddress)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .overlay(RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray.opacity(0.3)))
            .padding(.horizontal)
            .padding(.top, 60)
            
            Spacer()
        }
        .redacted(reason: userViewModel.viewState.isColorsLoading ? .placeholder : [])
        .disabled(userViewModel.viewState.isColorsLoading)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Additional Info")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    userViewModel.viewState.showInfoView = false
                }) {
                    Label("", systemImage: "chevron.left")
                }
                .tint(.white)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Next") {
                    userViewModel.viewState.showReviewView = true
                }
                .foregroundStyle(.white)
                .padding(.trailing, 8)
                .border(Color.white, width: 1, cornerRadius: 4)
                .redacted(reason: userViewModel.viewState.isColorsLoading ? .placeholder : [])
                .disabled(userViewModel.viewState.isColorsLoading)
            }
        }
        .background(
            Group {
                NavigationLink(
                    "",
                    destination: ColorsView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $userViewModel.viewState.showColorsView
                )
                .isDetailLink(false)
                
                NavigationLink(
                    "",
                    destination: ReviewView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $userViewModel.viewState.showReviewView
                )
                .isDetailLink(false)
            }
        )
    }
}

#Preview {
    InfoView()
}
