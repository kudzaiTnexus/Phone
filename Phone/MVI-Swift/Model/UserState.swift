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
    var teamMembers: [UserData] = []
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
        error = nil
    }
}
