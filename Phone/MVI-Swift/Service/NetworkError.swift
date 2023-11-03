//
//  NetworkError.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case encodingError(Error)
    case networkError(Error)
    case unknown
}

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.decodingError, .decodingError):
            return true
        case (.encodingError, .encodingError):
            return true
        case (.networkError, .networkError):
            return true
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
