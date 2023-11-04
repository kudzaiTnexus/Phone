//
//  ResultViewController.swift
//  Phone
//
//  Created by KudzaisheMhou on 04/11/2023.
//

import Foundation
import UIKit
import Lottie

class ResultViewController: UIViewController {
    
    var userViewModel: UserViewModel
    private let router = Resolver.resolve(dependency: Router.self)
    
    private lazy var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "success")
        animationView.loopMode = .playOnce
        animationView.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
        animationView.center = CGPoint(x: view.center.x, y: view.center.y - 200)
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageLabel.textAlignment = .center
        messageLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est leo, vehicula eu eleifend non, auctor ut arcu, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse est leo, vehicula eu eleifend non, auctor ut arcu"
        messageLabel.sizeToFit()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageLabel
    }()
    
    private lazy var succesLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        messageLabel.textAlignment = .center
        messageLabel.text = "Success"
        messageLabel.sizeToFit()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageLabel
    }()
    
    private lazy var doneButton: UIButton = {
       let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        doneButton.backgroundColor = .blue
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = 4
        doneButton.frame = CGRect(x: (view.frame.width - 180) / 2, y: view.frame.height - 80, width: 180, height: 40)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return doneButton
    }()
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(animationView)
        view.addSubview(succesLabel)
        view.addSubview(messageLabel)
        view.addSubview(doneButton)
        
        setupView()
    }
    
    func setupView() {
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            succesLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 16),
            succesLabel.centerXAnchor.constraint(equalTo: animationView.centerXAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: succesLabel.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    @objc func doneButtonTapped() {
        router.popToViewControllerType(HomeViewController.self)
        userViewModel.viewState.showSuccessView = false
    }
}
