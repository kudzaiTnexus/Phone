//
//  URLSessionDataTaskProtocol.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionDataTaskProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        let (data, response) = try await self.data(for: request, delegate: nil)
        return (data, response)
    }
}
