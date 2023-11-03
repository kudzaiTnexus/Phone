//
//  MockUserService.swift
//  PhoneTests
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
@testable import Phone

class MockUserService: UserService {
    var shouldReturnError = false
    var mockLoginResponse: LoginResponse!
    var mockUserResponse: UserResponse!
    var mockUserDataInfo: UserDataInfo!
    var mockColorResponse: ColorResponse!
    
    func login(with username: String, password: String) async throws -> LoginResponse {
        if shouldReturnError { throw NetworkError.unknown }
        return Mocks.loginResponse
    }
    
    func employees() async throws -> UserResponse {
        if shouldReturnError { throw NetworkError.unknown }
        return Mocks.userResponse
    }
    
    func teamMembers(request: UserDataInfo) async throws -> UserDataInfo {
        if shouldReturnError { throw NetworkError.unknown }
        return Mocks.userDataInfo
    }
    
    func colors() async throws -> ColorResponse {
        if shouldReturnError { throw NetworkError.unknown }
        return Mocks.colorResponse
    }
}
