//
//  UserIntent.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

enum UserIntent {
    case login(username: String, password: String)
    case employees
    case teamMembers
    case colors
    case clearError
    
    
    case selectEmployee(UserData)
}
