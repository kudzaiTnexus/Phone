//
//  UserDataInfo.swift
//  Phone
//
//  Created by KudzaisheMhou on 02/11/2023.
//

import Foundation

struct PersonalDetails: Codable {
    let id: Int
    let email: String?
    let firstName: String?
    let lastName: String?
    let avatar: String?
    let dob: String?
    let gender: String?

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
        case dob = "DOB"
        case gender
    }
}

struct AdditionalInformation: Codable {
    let placeOfBirth: String?
    let preferredColor: String?
    let residentialAddress: String?

    enum CodingKeys: String, CodingKey {
        case placeOfBirth = "placeOfBirth"
        case preferredColor = "preferredColor"
        case residentialAddress = "residentialAddress"
    }
}

struct UserDataInfo: Codable {
    let userLoginToken: String
    let personalDetails: PersonalDetails
    let additionalInformation: AdditionalInformation
}
