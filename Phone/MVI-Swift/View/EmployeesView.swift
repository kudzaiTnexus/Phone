//
//  EmployeesView.swift
//  Phone
//
//  Created by KudzaisheMhou on 02/11/2023.
//

import SwiftUI

struct EmployeesView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            LazyVStack(spacing: 0) {
                ForEach(0...5, id: \.self) { _ in
                    CardView(
                        showTitle: false,
                        showChevron: false,
                        showCircle: false, 
                        infoArray: ["Full Name", "Email"]
                    )
                    .onTapGesture {
                        userViewModel.viewState.showEmployees = false
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("LIST OF EMPLOYEES")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    userViewModel.viewState.showEmployees = false
                }) {
                    Label("", systemImage: "chevron.left")
                }
                .tint(.white)
            }
        }
    }
}

#Preview {
    EmployeesView()
}
