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
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func post<T: Decodable, U: Encodable>(_ urlString: String, body: U, headers: [String: String]? = nil) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        do {
            let requestBody = try JSONEncoder().encode(body)
            request.httpBody = requestBody
        } catch {
            throw NetworkError.encodingError(error)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
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

extension Data {
    func debug_description() -> String?{
        return String(data: self, encoding: .utf8)
    }
    
    func debug_JsonString() -> NSString? {
        
        guard let _ = try? JSONSerialization.jsonObject(with: self, options: []) else {
            return nil
        }
        
        guard let string = String(data: self, encoding: .utf8) else {
            return nil
        }
        
        return NSString(string: string)
    }
}
