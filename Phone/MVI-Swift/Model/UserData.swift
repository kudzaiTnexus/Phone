//
//  UserData.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

// MARK: - UserData
struct UserData: Codable, Hashable, Identifiable {
    let id: Int
    let email, firstName, lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
