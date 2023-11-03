//
//  ReviewView.swift
//  Phone
//
//  Created by KudzaisheMhou on 02/11/2023.
//

import SwiftUI

struct ReviewView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var username: String = ""
    
    var body: some View {
        VStack {
            
            CardView(
                showTitle: true,
                showChevron: false,
                showCircle: false,
                title: "Personal Details",
                avatar: userViewModel.viewState.selectedEmployee?.avatar ?? "",
                infoArray: [
                    (userViewModel.viewState.selectedEmployee?.firstName ?? "" + (userViewModel.viewState.selectedEmployee?.lastName ?? "")),
                    userViewModel.viewState.selectedEmployee?.email ?? "",
                    userViewModel.viewState.dateOfBirth,
                    userViewModel.viewState.gender
                ]
            )
            .padding(.top, 60)
            
            VStack {
                HStack {
                    Text("Additional Infomation")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black)
                    
                    Spacer()
                }
                .padding(.vertical)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(userViewModel.viewState.selectedColor?.name ?? "")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.black)
                        
                        Text(userViewModel.viewState.placeOfBirth)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.black)
                        
                        Text(userViewModel.viewState.residentialAddress)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
            }
            .padding(.top, 24)
            
            Divider()
            
            Spacer()
            
            Button(action: {
                userViewModel.intent(.teamMembers)
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .font(.body)
                    .frame(width: 180, height: 40)
            }
            .background(Color.blue)
            .cornerRadius(4)
            .padding(.bottom, 40)
            
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Review")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    userViewModel.viewState.showReviewView = false
                }) {
                    Label("", systemImage: "chevron.left")
                }
                .tint(.white)
            }
        }
        .fullScreenCover(isPresented: $userViewModel.viewState.showSuccessView) {
            ResultView()
        }
    }
}

#Preview {
    ReviewView()
}
