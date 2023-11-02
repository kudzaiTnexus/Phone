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
            load( { try await self.userService.login(with: username, password: password) },
                  completion: { [weak self] result in
                    switch result {
                    case .success(let loginResponse):
                        self?.viewState.login = loginResponse
                        self?.viewState.isLoggedIn = true
                    case .failure(let error):
                        self?.viewState.error = error
                    }
               }
            )
        case .employees: break
//            load { try await self.userService.employees() }
//            update: { self.viewState.employees = $0.data ?? [] }
        case .teamMembers: break
//            load { try await self.userService.teamMembers() }
//            update: { self.viewState.teamMembers = $0.data ?? [] }
        case .colors: break
//            load{ try await self.userService.colors() }
//            update: { self.viewState.colorsData = $0.data ?? [] }
        case .clearError:
            viewState.error = nil
        }
    }
    
    private func load<T>(
        _ operation: @escaping () async throws -> T,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        viewState.isLoading = true
        Task {
            do {
                let result = try await operation()
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            self.viewState.isLoading = false
        }
    }
}
