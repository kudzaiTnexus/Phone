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
    var isLoading: Bool = false
    var error: Error? = nil
}
