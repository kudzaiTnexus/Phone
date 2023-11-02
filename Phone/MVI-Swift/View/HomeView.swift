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
    @State var showDatePicker: Bool = false
    @State private var selectedDate: Date = Date()
    
    var employee: UserData? {
        userViewModel.viewState.selectedEmployee ??
        userViewModel.viewState.employees.first
    }
    
    var body: some View {
        VStack {
            
            CardView(
                showTitle: true,
                showChevron: true,
                showCircle: false,
                title: "Select an Employee",
                avatar: employee?.avatar ?? "",
                infoArray: [
                    employee?.firstName ?? ".....",
                    employee?.email ?? ".........."
                ]
            )
            .padding(.top, 60)
            .onTapGesture {
                userViewModel.viewState.showEmployees = true
            }
            
            VStack {

                HStack {
                    DatePicker("",
                               selection: $selectedDate,
                               displayedComponents: [.date])
                    .opacity(0.05)
                    .frame(width: 100)
                    
                    Spacer()
                }
                .overlay(
                        HStack {
                            Text(userViewModel.viewState.dateOfBirth.isEmpty ? "Date of Birth...": userViewModel.viewState.dateOfBirth)
                                .foregroundColor(userViewModel.viewState.dateOfBirth.isEmpty ? .gray.opacity(0.5) : .primary)
                            Spacer()
                        }
                    .padding(10)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray.opacity(0.3)))
                    .allowsHitTesting(false)
                )
                .onChange(of: selectedDate) { val in
                    userViewModel.viewState.dateOfBirth = DateFormatter.yyyyMMdd.string(from: val)
                }
                
                TextField("Place of Birth...", text: $userViewModel.viewState.placeOfBirth)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .overlay(RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray.opacity(0.3)))
                    .onChange(of: userViewModel.viewState.placeOfBirth) { newValue in
                        userViewModel.intent(.updatePlaceOfBirth(newValue))
                    }
            }
            .padding(.horizontal)
            .padding(.top, 60)
            
            Spacer()
        }
        .overlay(
            Group {
                if userViewModel.viewState.isEmployeesLoading {
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                }
            }
        )
        .disabled(userViewModel.viewState.isEmployeesLoading)
        .id(userViewModel.viewState.homeId)
        .redacted(reason: userViewModel.viewState.isEmployeesLoading ? .placeholder : [])
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
                .redacted(reason: userViewModel.viewState.isEmployeesLoading ? .placeholder : [])
                .disabled(userViewModel.viewState.isEmployeesLoading)
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

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

#Preview {
    HomeView()
}
