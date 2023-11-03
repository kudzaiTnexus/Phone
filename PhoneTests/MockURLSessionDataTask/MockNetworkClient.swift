//
//  MockNetworkClient.swift
//  PhoneTests
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
@testable import Phone

class MockNetworkClient: NetworkClient {
    
    var getResponse: Decodable?
    var getError: Error?
    var postResponse: Decodable?
    var postError: Error?
    
    func get<T>(_ urlString: String) async throws -> T where T : Decodable {
        if let getError = getError {
            throw getError
        }
        
        return getResponse as! T
    }
    
    func post<T, U>(_ urlString: String, body: U, headers: [String : String]?) async throws -> T where T : Decodable, U : Encodable {
        if let postError = postError {
            throw postError
        }
        
        return postResponse as! T
    }
}
