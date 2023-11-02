//
//  UserServiceImplementation.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

class UserServiceImplementation: UserService {
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func login(with username: String, password: String) async throws -> LoginResponse {
        let url = try getUrl(for: .login)
        let requestBody = LoginRequestBody(username: username, password: password)
        return try await networkClient.post(url, body: requestBody, headers: nil)
    }
    
    func employees() async throws -> UserResponse {
        let url = try getUrl(for: .employees)
        return try await networkClient.get(url)
    }
    
    func teamMembers(request: UserDataInfo) async throws -> UserDataInfo {
        let url = try getUrl(for: .teamMembers)
        return try await networkClient.post(url, body: request, headers: nil)
    }
    
    func colors() async throws -> ColorResponse {
        let url = try getUrl(for: .colors)
        return try await networkClient.get(url)
    }
    
    private func getUrl(for endpointKey: EndpointKey) throws -> String {
        guard let baseUrlString = EndpointKey.baseUrl.endpoint,
              let endpointUrlString = endpointKey.endpoint else {
            throw NetworkError.invalidURL
        }
        
        return baseUrlString + endpointUrlString
    }

}
