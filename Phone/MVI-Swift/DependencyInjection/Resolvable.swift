//
//  Resolvable.swift
//  Phone
//
//  Created by KudzaisheMhou on 04/11/2023.
//

import Foundation
import Swinject

public protocol Resolvable {
    func resolve<T>(_ dependency: T.Type) -> T
    func reset()
}

public protocol Registrable {
    func register<T>(depedency: T.Type, implemenation: @escaping () -> T)
    func registerSingleton<T>(depedency: T.Type, implemenation: @escaping () -> T)
}

public protocol Resolving {
    static func resolve<T>( dependency: T.Type) -> T
    static func reset()
}

class Resolver {
    private static var container: Resolvable = DependencyInjectionContainer.instance
}

extension Resolver : Resolving {
    
    public static func resolve<T>(dependency: T.Type) -> T {
        return container.resolve(dependency)
    }
    public static func reset() {
        container.reset()
    }
    
    public static func resolveMainActor<Dependency>(_ dependencyType: Dependency.Type) async -> Dependency? {
           // Directly switch to the main actor context to resolve the dependency.
           return await withCheckedContinuation { continuation in
               // Perform the actual resolution on the main thread.
               Task { @MainActor in
                   let resolved = container.resolve(dependencyType)
                   continuation.resume(returning: resolved)
               }
           }
       }
}
