//
//  NetworkClient.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

protocol NetworkClient {
    func get<T: Decodable>(_ urlString: String) async throws -> T
}
