//
//  MockData.swift
//  PhoneTests
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
@testable import Phone

struct Mocks {
    
    // Mock for ColorResponse
    static var colorResponse: ColorResponse {
        return ColorResponse(page: 1, perPage: 10, total: 50, totalPages: 5, data: [colorData], support: support) // The colorData is already in an array format
    }

    
    static var colorData: ColorData {
        return ColorData(id: 1, name: "Red", year: 2021, color: "#FF0000", pantoneValue: "17-5104")
    }

    // Mock for UserDataInfo
    static var userDataInfo: UserDataInfo {
        return UserDataInfo(userLoginToken: "sampleToken123", personalDetails: personalDetails, additionalInformation: additionalInformation)
    }
    
    static var personalDetails: PersonalDetails {
        return PersonalDetails(id: 1, email: "test@example.com", firstName: "John", lastName: "Doe", avatar: "https://example.com/avatar.jpg", dob: "1990-01-01", gender: "Male")
    }
    
    static var additionalInformation: AdditionalInformation {
        return AdditionalInformation(placeOfBirth: "Earth", preferredColor: "Blue", residentialAddress: "123 Main St")
    }
    
    // Mock for UserResponse
    static var userResponse: UserResponse {
        return UserResponse(page: 1, perPage: 10, total: 50, totalPages: 5, data: [userData], support: support)
    }
    
    static var userData: UserData {
        return UserData(id: 1, email: "test@example.com", firstName: "John", lastName: "Doe", avatar: "https://example.com/avatar.jpg")
    }
    
    // Mock for LoginResponse
    static var loginResponse: LoginResponse {
        return LoginResponse(token: "sampleToken123")
    }
    
    // Support mock (assuming Support is a struct you have defined)
    static var support: Support {
        return Support(url: "https://example.com/support", text: "Sample support text")
    }

}

extension ColorResponse: Equatable {
    public static func == (lhs: Phone.ColorResponse, rhs: Phone.ColorResponse) -> Bool {
        lhs.page == rhs.page
    }
}

extension PersonalDetails: Equatable {
    public static func == (lhs: PersonalDetails, rhs: PersonalDetails) -> Bool {
        lhs.id == rhs.id
    }
}

extension AdditionalInformation: Equatable {
    public static func == (lhs: AdditionalInformation, rhs: AdditionalInformation) -> Bool {
        lhs.placeOfBirth == rhs.placeOfBirth
    }
}

extension UserDataInfo: Equatable {
    public static func == (lhs: UserDataInfo, rhs: UserDataInfo) -> Bool {
        lhs.userLoginToken == rhs.userLoginToken
    }
}

extension UserResponse: Equatable {
    public static func == (lhs: Phone.UserResponse, rhs: Phone.UserResponse) -> Bool {
        lhs.page == rhs.page
    }
}

extension LoginResponse: Equatable {
    public static func == (lhs: LoginResponse, rhs: LoginResponse) -> Bool {
        lhs.token == rhs.token
    }
}
