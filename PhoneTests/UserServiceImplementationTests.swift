//
//  UserServiceImplementationTests.swift
//  PhoneTests
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
import XCTest
@testable import Phone

class UserServiceImplementationTests: XCTestCase {

    var userService: UserServiceImplementation!
    var mockNetworkClient: MockNetworkClient!

    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        userService = UserServiceImplementation(networkClient: mockNetworkClient)
    }

    func testLogin() async {
        let loginResponse = Mocks.loginResponse
        mockNetworkClient.postResponse = loginResponse

        do {
            let response = try await userService.login(with: "username", password: "password")
            XCTAssertEqual(response, loginResponse)
        } catch {
            XCTFail("Expected success but got \(error)")
        }
    }

    func testEmployees() async {
        let userResponse = Mocks.userResponse
        mockNetworkClient.getResponse = userResponse

        do {
            let response = try await userService.employees()
            XCTAssertEqual(response, userResponse)
        } catch {
            XCTFail("Expected success but got \(error)")
        }
    }

    func testTeamMembers() async {
        let userDataInfo = Mocks.userDataInfo
        mockNetworkClient.postResponse = userDataInfo

        do {
            let response = try await userService.teamMembers(request: userDataInfo)
            XCTAssertEqual(response, userDataInfo)
        } catch {
            XCTFail("Expected success but got \(error)")
        }
    }

    func testColors() async {
        let colorResponse = Mocks.colorResponse
        mockNetworkClient.getResponse = colorResponse

        do {
            let response = try await userService.colors()
            XCTAssertEqual(response, colorResponse)
        } catch {
            XCTFail("Expected success but got \(error)")
        }
    }
}
