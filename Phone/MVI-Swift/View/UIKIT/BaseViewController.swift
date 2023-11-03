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
    
    private func setBackNavigation() {
        let backImage = UIImage(systemName: "chevron.left")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
