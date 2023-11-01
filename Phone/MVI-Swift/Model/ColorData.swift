//
//  Datum.swift
//  Phone
//
//  Created by KudzaisheMhou on 31/10/2023.
//

import Foundation

struct ColorData: Codable {
    let id: Int?
    let name: String?
    let year: Int?
    let color, pantoneValue: String?

    enum CodingKeys: String, CodingKey {
        case id, name, year, color
        case pantoneValue = "pantone_value"
    }
}
