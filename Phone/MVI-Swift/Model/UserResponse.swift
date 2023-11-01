//
//  UserResponse.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

// MARK: - UserResponse
struct UserResponse: Codable {
    let page, perPage, total, totalPages: Int?
    let data: [UserData]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}
