//
//  ColorResponse.swift
//  Phone
//
//  Created by KudzaisheMhou on 02/11/2023.
//

import Foundation

struct ColorResponse: Codable {
    let page, perPage, total, totalPages: Int?
    let data: [ColorData]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}
