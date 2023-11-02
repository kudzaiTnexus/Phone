//
//  PhoneApp.swift
//  Phone
//
//  Created by KudzaisheMhou on 31/10/2023.
//

import SwiftUI

let navBarAppearence = UINavigationBarAppearance()

@main
struct PhoneApp: App {
    
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
                LoginView()
            }
            .environmentObject(userViewModel)
//            .fullScreenCover(isPresented: $userViewModel.viewState.showSuccessView) { 
//                ResultView()
//                    .environmentObject(userViewModel)
//            }
        }
    }
}
