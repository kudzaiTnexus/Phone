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
    
    private let userService = Resolver.resolve(dependency: UserService.self)
    private let router = Resolver.resolve(dependency: Router.self)

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
                        self?.router.routeToHome(userViewModel: self!)
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
                        self?.viewState.checkAndSelectEmployee()
                    case .failure(let error):
                        self?.viewState.error = error
                    }
                self?.viewState.isEmployeesLoading = false
               }
            )
        case .teamMembers:
            load( { [weak self] in
                
                guard let self ,
                      let selectedEmployee = viewState.selectedEmployee else {
                    self?.viewState.showErrorView = true
                    throw NetworkError.unknown
                }
                
                self.viewState.isTeamMembersLoading = true
                
                let request = UserDataInfo(
                    userLoginToken: viewState.login?.token ?? "",
                    personalDetails: PersonalDetails(
                        id: selectedEmployee.id,
                        email: selectedEmployee.email,
                        firstName: selectedEmployee.firstName,
                        lastName: selectedEmployee.lastName,
                        avatar: selectedEmployee.avatar,
                        dob: viewState.dateOfBirth,
                        gender: viewState.gender
                    ),
                    additionalInformation: AdditionalInformation(
                        placeOfBirth: viewState.placeOfBirth,
                        preferredColor: viewState.selectedColor?.color,
                        residentialAddress: viewState.residentialAddress
                    )
                )
                
                return try await self.userService.teamMembers(request: request)
            },
                  completion: { [weak self] result in
                    switch result {
                    case .success(let teamData):
                        self?.viewState.teamMembers = teamData 
                        self?.viewState.showSuccessView = true
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
                        self?.viewState.checkAndSelectColor()
                    case .failure(let error):
                        self?.viewState.error = error
                    }
                self?.viewState.isColorsLoading = false
               }
            )
        case .selectEmployee(let employee):
            viewState.selectedEmployee = employee
        case .selectedColor(let color):
            viewState.selectedColor = color
        case .updateDateOfBirth(let newDateOfBirth):
            viewState.dateOfBirth = newDateOfBirth
            validateDateOfBirth()
        case .updatePlaceOfBirth(let newPlaceOfBirth):
            viewState.placeOfBirth = newPlaceOfBirth
            validatePlaceOfBirth()
        case .clearError:
            viewState.error = nil
        }
    }
    
    private func validateDateOfBirth() {
        // Validation logic for dateOfBirth
    }
    
    private func validatePlaceOfBirth() {
        // Validation logic for dateOfBirth
    }
    
    private func postLoginDataFetch() {
        intent(.employees)
        intent(.colors)
    }
    
    private func load<T>(
        _ operation: @escaping () async throws -> T,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        viewState.showErrorView = false
        Task {
            do {
                let result = try await operation()
                completion(.success(result))
            } catch {
                completion(.failure(error))
                viewState.showErrorView = true
            }
        }
    }
}
