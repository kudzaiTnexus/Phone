//
//  PhoneApp.swift
//  Phone
//
//  Created by KudzaisheMhou on 31/10/2023.
//

import SwiftUI

let navBarAppearence = UINavigationBarAppearance()

enum ViewType {
    case uiKit
    case swiftUI
    case objectiveC
    case splashScreen
}

@main
struct PhoneApp: App {
    @State private var isActive: ViewType = .splashScreen
    
    @StateObject var userViewModel: UserViewModel = UserViewModel(userService: UserServiceImplementation(networkClient: NetworkClientImplementation()))
    
    init() {
        navBarAppearence.configureWithOpaqueBackground()
        navBarAppearence.backgroundColor = .blue
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
               
        UINavigationBar.appearance().standardAppearance = navBarAppearence
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearence
    }
          
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch isActive {
                case .uiKit:
                    LoginViewControllerRepresentable()
                case .swiftUI:
                    LoginView()
                case .objectiveC:
                    EmptyView()
                case .splashScreen:
                    SplashScreen(isActive: $isActive)
                }
            }
            .environmentObject(userViewModel)
            .overlay(
                Group {
                    if userViewModel.viewState.isTeamMembersLoading {
                        ZStack {
                            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                            
                            ProgressView()
                                .scaleEffect(1.5, anchor: .center)
                        }
                    }
                }
            )
        }
    }
}
