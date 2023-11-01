//
//  UserViewModel.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    
    @Published private(set) var viewState = UserState()
    
    private var userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }

    func intent(_ intent: UserIntent) {
        switch intent {
        case .login(let username, let password):
            load { try await self.userService.login(with: username, password: password) }
            update: { self.viewState.login = $0 }
        case .employees:
            load { try await self.userService.employees() }
            update: { self.viewState.employees = $0.data ?? [] }
        case .teamMembers:
            load { try await self.userService.teamMembers() }
            update: { self.viewState.teamMembers = $0.data ?? [] }
        case .colors:
            load{ try await self.userService.colors() }
            update: { self.viewState.colorsData = $0.data ?? [] }
        case .clearError:
            viewState.error = nil
        }
    }
    
    private func load<T>(
        _ operation: @escaping () async throws -> T,
        update: @escaping (T) -> Void
    ) {
        viewState.isLoading = true
        Task {
            do {
                let result = try await operation()
                update(result)
            } catch {
                self.viewState.error = error
            }
            self.viewState.isLoading = false
        }
    }
}
