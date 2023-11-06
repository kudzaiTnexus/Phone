//
//  LoginViewController.swift
//  Phone
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
import UIKit
import Lottie
import SwiftUI
import Combine

struct LoginViewControllerRepresentable: UIViewControllerRepresentable {
    
    @EnvironmentObject var userViewModel: UserViewModel
    private var router = Resolver.resolve(dependency: Router.self)
    
    func makeUIViewController(context: Context) ->  LoginViewController {
        let viewController = LoginViewController()
        viewController.userViewModel = userViewModel
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        
    }
}

class LoginViewController: UIViewController {
    
    var userViewModel: UserViewModel?
    
    private var cancellables: Set<AnyCancellable> = []
    private var router = Resolver.resolve(dependency: Router.self)
    
    private var usernameTextField: UITextField = {
        let usernameTextField = UITextField()
        usernameTextField.placeholder = "Enter username..."
        usernameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        usernameTextField.autocapitalizationType = .none
        return usernameTextField
    }()
    
    
    private var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return passwordTextField
    }()
    
    private var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return loginButton
    }()
    
    private var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.text = "Something went wrong, Incorrect username or password"
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        errorLabel.numberOfLines = 2
        errorLabel.isHidden = true
        return errorLabel
    }()
    
    private var errorAnimationView: LottieAnimationView = {
        let errorAnimationView = LottieAnimationView(name: "error")
        errorAnimationView.loopMode = .playOnce
        errorAnimationView.isHidden = true
        return errorAnimationView
    }()
    
    private var loadingOverlayView: UIView = {
        let loadingOverlayView = UIView()
        loadingOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        loadingOverlayView.layer.cornerRadius = 8
        loadingOverlayView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingOverlayView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingOverlayView.isHidden = true
        return loadingOverlayView
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.distribution = .fillEqually
        return mainStackView
    }()
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        router.update(self.navigationController)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupBinding() {
        userViewModel?.$viewState
            .sink(receiveValue: { [weak self] state in
                guard let self = self else { return }
                loadingOverlayView.isHidden = !state.isLoginLoading
            })
            .store(in: &cancellables)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        configureTextField(usernameTextField)
        configureTextField(passwordTextField)

        loadingOverlayView.addSubview(activityIndicator)
        
        mainStackView.addArrangedSubview(usernameTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(errorAnimationView)
        mainStackView.addArrangedSubview(errorLabel)
        mainStackView.addArrangedSubview(loginButton)
        
        view.addSubview(mainStackView)
        view.addSubview(loadingOverlayView)
    }
    
    private func setupLayout() {
        // Using Auto Layout
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorAnimationView.translatesAutoresizingMaskIntoConstraints = false
        loadingOverlayView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            // Loading OverlayView
            loadingOverlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingOverlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: loadingOverlayView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingOverlayView.centerYAnchor),

            // Activity Indicator
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            mainStackView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
        ])
    }
    
    private func configureTextField(_ textField: UITextField) {
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc private func textFieldDidChange() {
        let isInputValid = !(usernameTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true)
        loginButton.isEnabled = isInputValid
        loginButton.backgroundColor = isInputValid ? .blue : UIColor.gray.withAlphaComponent(0.5)
    }
    
    @objc private func didTapLoginButton() {
        userViewModel?.intent(
            .login(
                username: usernameTextField.text ?? "",
                password: passwordTextField.text ?? "")
        )
    }
    
    private func showError() {
        errorLabel.isHidden = false
        errorAnimationView.isHidden = false
        errorAnimationView.play()
    }
}
