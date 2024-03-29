//
//  UserState.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

struct UserState {
    var login: LoginResponse? = nil
    var employees: [UserData] = []
    var teamMembers: UserDataInfo? = nil
    var colorsData: [ColorData] = []
    
    var homeId: UUID = UUID()
    
    var isLoginLoading: Bool = false
    var isTeamMembersLoading: Bool = false
    var isEmployeesLoading: Bool = false
    var isColorsLoading: Bool = false
    
    var isLoggedIn: Bool = false
    var showEmployees: Bool = false
    var showInfoView: Bool = false
    var showColorsView: Bool = false
    var showReviewView: Bool = false
    var showErrorView: Bool = false
    var showSuccessView: Bool = false
    
    var error: Error? = nil
    
    var selectedEmployee: UserData?
    var selectedColor: ColorData?
    var dateOfBirth: String = ""
    var placeOfBirth: String = ""
    var selectedGender: Int = 0
    var residentialAddress: String = ""
    
    var gender: String {
        switch selectedGender {
        case 0:
            return "Male"
        case 1:
            return "Female"
        case 2:
            return "Other"
        default:
            return ""
        }
    }
    
    mutating func resetToDefault() {
        isLoginLoading = false
        isTeamMembersLoading = false
        isEmployeesLoading = false
        isColorsLoading = false
        showEmployees = false
        showInfoView = false
        showColorsView = false
        showReviewView = false
        showErrorView = false
        showSuccessView = false
        selectedGender = 0
        residentialAddress = ""
        error = nil
    }
    
    
    mutating func checkAndSelectEmployee() {
        // If selectedEmployee is nil and there are employees available
        if selectedEmployee == nil && !employees.isEmpty {
            // Select the first employee
            selectedEmployee = employees.first
        }
    }

    mutating func checkAndSelectColor() {
        // If selectedColor is nil and there are colors available
        if selectedColor == nil && !colorsData.isEmpty {
            // Select the first color
            selectedColor = colorsData.first
        }
    }

}
