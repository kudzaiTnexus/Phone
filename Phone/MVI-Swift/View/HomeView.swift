//
//  HomeView.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            
            CardView(
                showTitle: true,
                showChevron: true,
                showCircle: false,
                infoArray: ["Full Name", "Email"]
            )
            .padding(.top, 60)
            .onTapGesture {
                userViewModel.viewState.showEmployees = true
            }
            
            VStack {
                TextField("Date of Birth...", text: $username)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .overlay(RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray.opacity(0.3)))
                
                TextField("Place of Birth...", text: $username)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .overlay(RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray.opacity(0.3)))
            }
            .padding(.horizontal)
            .padding(.top, 60)
            
            Spacer()
        }
        .id(userViewModel.viewState.homeId)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Employee")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Next") {
                    userViewModel.viewState.showInfoView = true
                }
                .foregroundStyle(.white)
                .padding(.trailing, 8)
                .border(Color.white, width: 1, cornerRadius: 4)
            }
        }
        .background(
            Group {
                NavigationLink(
                    "",
                    destination: EmployeesView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $userViewModel.viewState.showEmployees
                )
                .isDetailLink(false)
                
                
                NavigationLink(
                    "",
                    destination: InfoView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $userViewModel.viewState.showInfoView
                )
                .isDetailLink(false)
            }
        )
        .onChange(of: userViewModel.viewState.homeId) { _ in
            userViewModel.viewState.resetToDefault()
        }
    }
}

extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
}

#Preview {
    HomeView()
}
