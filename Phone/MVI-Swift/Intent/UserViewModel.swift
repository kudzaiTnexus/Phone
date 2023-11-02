//
//  UserViewModel.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    
    @Published var viewState = UserState()
    
    private var userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }

    func intent(_ intent: UserIntent) {
        switch intent {
        case .login(let username, let password):
            load( { [weak self] in
                self?.viewState.isLoginLoading = true
               return try await self?.userService.login(with: username, password: password)
            },
                  completion: { [weak self] result in
                    switch result {
                    case .success(let loginResponse):
                        self?.viewState.login = loginResponse
                        self?.postLoginDataFetch()
                        self?.viewState.isLoggedIn = true
                    case .failure(let error):
                        self?.viewState.error = error
                    }
                
                self?.viewState.isLoginLoading = false
               }
            )
        case .employees:
            load( { [weak self] in
                self?.viewState.isEmployeesLoading = true
                return try await self?.userService.employees()
            },
                  completion: { [weak self] result in
                    switch result {
                    case .success(let employeesData):
                        self?.viewState.employees = employeesData?.data ?? []
                    case .failure(let error):
                        self?.viewState.error = error
                    }
                self?.viewState.isEmployeesLoading = false
               }
            )
        case .teamMembers:
            load( { [weak self] in
                self?.viewState.isTeamMembersLoading = true
                return try await self?.userService.teamMembers()
            },
                  completion: { [weak self] result in
                    switch result {
                    case .success(let teamData):
                        self?.viewState.teamMembers = teamData?.data ?? []
                    case .failure(let error):
                        self?.viewState.error = error
                    }
                
                self?.viewState.isTeamMembersLoading = false
               }
            )
        case .colors:
            load( { [weak self] in
                self?.viewState.isColorsLoading = true
                return try await self?.userService.colors() },
                  completion: { [weak self] result in
                    switch result {
                    case .success(let colorData):
                        self?.viewState.colorsData = colorData?.data ?? []
                    case .failure(let error):
                        self?.viewState.error = error
                    }
                self?.viewState.isColorsLoading = false
               }
            )
        case .selectEmployee(let employee):
            viewState.selectedEmployee = employee
        case .clearError:
            viewState.error = nil
        }
    }
    
    private func postLoginDataFetch() {
        intent(.teamMembers)
        intent(.employees)
        intent(.colors)
    }
    
    private func load<T>(
        _ operation: @escaping () async throws -> T,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        Task {
            do {
                let result = try await operation()
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
