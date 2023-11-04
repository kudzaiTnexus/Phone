//
//  BaseViewController.swift
//  Phone
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
import UIKit


public class BaseViewController: UIViewController {
    
    
    // MARK: Overrides
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setBackNavigation()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Private Functions
    
    private func setupNavigationBar() {
        navigationController?.configure(
            navBarBackgroundColor:
                UIColor.blue,
            foregroundColor: .white,
            barStyle: .black)
    }
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func setBackNavigation() {
        let backImage = UIImage(systemName: "chevron.left")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.barTintColor = .white
        UINavigationBar.appearance().barTintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupNavigationBarButton() {
        // Create a button with type custom to apply your custom styles
        let button = UIButton(type: .custom)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        // Since the button is going to be in the navigation bar, its size needs to be predefined
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 24)

        // Wrap the button in a UIBarButtonItem
        let barButtonItem = UIBarButtonItem(customView: button)
        
        // Set the navigation item's right bar button item
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func nextButtonTapped() {
        // Perform the next button's action
        print("Next button tapped!")
    }
    
}

extension UINavigationController {
    func configure(navBarBackgroundColor: UIColor, foregroundColor: UIColor, barStyle: UIBarStyle = .default) {
        navigationBar.tintColor = foregroundColor
        navigationBar.barTintColor = navBarBackgroundColor
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: foregroundColor
        ]
        navigationBar.isTranslucent = false
        setNavigationBarHidden(false, animated: true)
        navigationBar.barStyle = barStyle
        navigationBar.shadowImage = UIImage()

        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = navBarBackgroundColor
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: foregroundColor
            ]
            appearance.shadowImage = UIImage()
            
            navigationBar.standardAppearance = appearance;
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
    }
    
}
