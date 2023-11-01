//
//  NetworkClientImplementation.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

class NetworkClientImplementation: NetworkClient {
    
    let session: URLSessionDataTaskProtocol
    
    init(session: URLSessionDataTaskProtocol = URLSession.shared) {
        self.session = session
    }
    
    func get<T: Decodable>(_ urlString: String) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
