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
    case networkError(Error)
    case unknown
}
