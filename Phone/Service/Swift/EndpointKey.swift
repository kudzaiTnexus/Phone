//
//  EndpointKey.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

enum EndpointKey: String {
    case baseUrl = "BaseURL"
    case login = "LoginEndpoint"
    case employees = "EmployeesEndpoint"
    case colors = "ColorEndpoint"
    case teamMembers = "TeamMembersEndPoint"
    
    var endpoint: String? {
        return Bundle.main.infoDictionary?[self.rawValue] as? String
    }
}
