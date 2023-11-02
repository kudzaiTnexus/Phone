//
//  UserService.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

protocol UserService {
    func login(with username: String, password: String) async throws -> LoginResponse
    func employees() async throws -> UserResponse
    func teamMembers(request: UserDataInfo) async throws -> UserDataInfo
    func colors() async throws -> ColorResponse
}
