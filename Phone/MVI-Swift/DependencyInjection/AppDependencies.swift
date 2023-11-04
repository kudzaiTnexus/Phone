//
//  AppDependencies.swift
//  Phone
//
//  Created by KudzaisheMhou on 04/11/2023.
//

import Foundation

class AppDependencies {
    
    static func registerAllApplicationDependencies() {
        let container = DependencyInjectionContainer.instance
        container.register(depedency: NetworkClient.self, implemenation: { NetworkClientImplementation() })
        container.register(depedency: UserService.self, implemenation: { UserServiceImplementation() })
        container.registerSingleton(depedency: Router.self, implemenation: { AppRouter() })
    }
}
