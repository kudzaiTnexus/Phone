//
//  UserViewModelTests.swift
//  PhoneTests
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
import XCTest
@testable import Phone

@MainActor
class UserViewModelTests: XCTestCase {
    
    var viewModel: UserViewModel!
    var mockService: MockUserService!
    
    override func setUp() {
        super.setUp()
        mockService = MockUserService()
        viewModel = UserViewModel(userService: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testLoginSuccessful() async throws {
        // Given
        mockService.mockLoginResponse = Mocks.loginResponse
        
        // When
        viewModel.intent(.login(username: "test", password: "test123"))
        
        // Allow some delay for async operation
        try await Task.sleep(nanoseconds: UInt64(0.1 * Double(NSEC_PER_SEC)))
        
        // Then
        XCTAssertEqual(viewModel.viewState.login?.token, "sampleToken123")
        XCTAssertTrue(viewModel.viewState.isLoggedIn)
    }
    
    func testLoginFailure() async throws {
        // Given
        mockService.shouldReturnError = true
        
        // When
        viewModel.intent(.login(username: "test", password: "test123"))
        
        // Allow some delay for async operation
        try await Task.sleep(nanoseconds: UInt64(0.1 * Double(NSEC_PER_SEC)))
        
        // Then
        XCTAssertNotNil(viewModel.viewState.error)
        XCTAssertFalse(viewModel.viewState.isLoggedIn)
    }
    
//    func testFetchEmployees() async {
//        let viewModel = UserViewModel(userService: mockService)
//        
//        viewModel.intent(.employees)
//        
//        XCTAssertEqual(viewModel.viewState.employees.count, 1)
//    }
    
//    func testFetchTeamMembers() async {
//        let viewModel = UserViewModel(userService: mockService)
//        
//        viewModel.intent(.teamMembers)
//        
//        XCTAssertNotNil(viewModel.viewState.teamMembers)
//    }
//    
//    func testFetchColors() async {
//        mockService.mockColorResponse = Mocks.colorResponse
//        let viewModel = UserViewModel(userService: mockService)
//        
//        viewModel.intent(.colors)
//        
//        XCTAssertFalse(viewModel.viewState.colorsData.isEmpty)
//    }
//    
//    func testErrorHandlingOnLogin() async {
//        let viewModel = UserViewModel(userService: mockService)
//        
//        viewModel.intent(.login(username: "testUser", password: "testPassword"))
//        
//        XCTAssertNotNil(viewModel.viewState.error)
//    }
    
    func testSelectEmployee() async {
        let viewModel = UserViewModel(userService: mockService)
        
        viewModel.intent(.selectEmployee(Mocks.userData))
        
        XCTAssertEqual(viewModel.viewState.selectedEmployee, Mocks.userData)
    }
    
}
