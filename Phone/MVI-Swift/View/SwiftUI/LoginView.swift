//
//  LoginView.swift
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

import SwiftUI
import Lottie

struct LoginView: View {
    @State var username: String = ""
    @State private var password: String = ""
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        ZStack {
            
            VStack {
                
                VStack {
                    TextField("Enter username...", text: $username)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .overlay(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray.opacity(0.3)))
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .overlay(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray.opacity(0.3)))
                        .textInputAutocapitalization(.never)
                    
                    if userViewModel.viewState.showErrorView {
                        errorView
                            .transition(AnyTransition.fadeIn.animation(.easeInOut)) // Direct animation application
                    }
                }
                .padding(.bottom, 40)
                
                
                Button(action: {
                    userViewModel.intent(.login(username: username, password: password))
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.body)
                        .frame(maxWidth: .infinity, minHeight: 40)
                }
                .background(username.isEmpty || password.isEmpty ? Color.gray.opacity(0.5) : Color.blue)
                .cornerRadius(4)
                .disabled(username.isEmpty || password.isEmpty)
            }
            
            if userViewModel.viewState.isLoginLoading {
                Color.black.opacity(0.2)
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                
                ProgressView()
                    .scaleEffect(1.5, anchor: .center)
            }
        
        }
        .disabled(userViewModel.viewState.isLoginLoading)
        .padding(.horizontal, 32)
        .background(
            Group {
                NavigationLink(
                    "",
                    destination: HomeView(),
                    isActive: $userViewModel.viewState.isLoggedIn
                )
                .isDetailLink(false)
            }
        )
    }
    
    @ViewBuilder
    var errorView: some View {
        HStack {
            HStack {
                LottieView(animation: .named("error"))
                    .playing()
                    .frame(width: 24, height: 24)
                
                Text("Something went wrong, Incorrect username or password")
                    .foregroundColor(.red)
                    .font(.system(size: 12, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            
            Spacer()
        }
    }
}

extension AnyTransition {
    static var fadeIn: AnyTransition {
        let insertion = AnyTransition.opacity.combined(with: .scale)
        let removal = AnyTransition.opacity
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

#Preview {
    LoginView()
}
