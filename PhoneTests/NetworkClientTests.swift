//
//  NetworkClientTests.swift
//  PhoneTests
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
import XCTest
@testable import Phone

class NetworkClientTests: XCTestCase {
    
    var sut: NetworkClientImplementation!
    var mockSession: MockURLSessionDataTask!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSessionDataTask()
        sut = NetworkClientImplementation(session: mockSession)
    }

    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testGet_Success() async {
        let jsonString = """
        {
            "key": "value"
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        mockSession.mockData = jsonData
        mockSession.mockResponse = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                                   statusCode: 200,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        
        do {
            let result: [String: String] = try await sut.get("http://example.com")
            XCTAssertEqual(result["key"], "value")
        } catch {
            XCTFail("Expected success but got \(error)")
        }
    }
    
    func testPost_Success() async {
        let jsonString = """
        {
            "responseKey": "responseValue"
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        mockSession.mockData = jsonData
        mockSession.mockResponse = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                                   statusCode: 200,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        
        do {
            let requestBody = ["key": "value"]
            let result: [String: String] = try await sut.post("http://example.com", body: requestBody)
            XCTAssertEqual(result["responseKey"], "responseValue")
        } catch {
            XCTFail("Expected success but got \(error)")
        }
    }
    
    func testGet_InvalidURL() async {
        do {
            _ = try await sut.get("") as DummyDecodable
            XCTFail("Expected invalidURL error but got success")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.invalidURL)
        } catch {
            XCTFail("Expected invalidURL error but got \(error)")
        }
    }

    func testGet_InvalidResponseCode() async {
        mockSession.mockResponse = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                                  statusCode: 404,
                                                  httpVersion: nil,
                                                  headerFields: nil)
        
        do {
            _ = try await sut.get("http://example.com") as DummyDecodable
            XCTFail("Expected invalidResponse error but got success")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.invalidResponse)
        } catch {
            XCTFail("Expected invalidResponse error but got \(error)")
        }
    }

    func testPost_InvalidURL() async {
        do {
            let requestBody = ["key": "value"]
            _ = try await sut.post("", body: requestBody) as DummyDecodable
            XCTFail("Expected invalidURL error but got success")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.invalidURL)
        } catch {
            XCTFail("Expected invalidURL error but got \(error)")
        }
    }

    func testPost_InvalidResponseCode() async {
        mockSession.mockResponse = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                                  statusCode: 404,
                                                  httpVersion: nil,
                                                  headerFields: nil)
        
        do {
            let requestBody = ["key": "value"]
            _ = try await sut.post("http://example.com", body: requestBody) as DummyDecodable
            XCTFail("Expected invalidResponse error but got success")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.invalidResponse)
        } catch {
            XCTFail("Expected invalidResponse error but got \(error)")
        }
    }

}
