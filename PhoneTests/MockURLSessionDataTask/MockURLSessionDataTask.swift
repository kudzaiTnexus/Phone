//
//  MockURLSessionDataTask.swift
//  PhoneTests
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
@testable import Phone

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        return (mockData ?? Data(), mockResponse ?? URLResponse())
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        return (mockData ?? Data(), mockResponse ?? URLResponse())
    }
}
