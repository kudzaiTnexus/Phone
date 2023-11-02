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
            ScrollView(.vertical, showsIndicators: false ) {
            LazyVStack(spacing: 0) {
                ForEach(userViewModel.viewState.employees, id: \.self) { employee in
                    CardView(
                        showTitle: false,
                        showChevron: false,
                        showCircle: false,
                        avatar: employee.avatar ?? "",
                        infoArray: [
                            employee.firstName ?? "",
                            employee.email ?? ""
                        ]
                    )
                    .onTapGesture {
                        userViewModel.intent(.selectEmployee(employee))
                        userViewModel.viewState.showEmployees = false
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
