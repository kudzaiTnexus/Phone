//
//  AppRouter.swift
//  Phone
//
//  Created by KudzaisheMhou on 04/11/2023.
//

import Foundation
import UIKit

protocol Router {
    func dismiss()
    func update(_ navigationController: UINavigationController?)
    func routeToHome(userViewModel: UserViewModel)
    func routeToEmployeesScreen(userViewModel: UserViewModel)
    func routeToInfoScreen(userViewModel: UserViewModel)
    func routeToColorsScreen(userViewModel: UserViewModel)
    func routeToReviewScreen(userViewModel: UserViewModel)
    func routeToResultScreen(userViewModel: UserViewModel)
    func popToViewControllerType(_ viewControllerType: UIViewController.Type)
}

class AppRouter: Router {
    public weak var navigationController: UINavigationController? = nil
    
    func update(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToHome(userViewModel: UserViewModel) {
        let homeVC = HomeViewController(userViewModel: userViewModel)
        navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func routeToEmployeesScreen(userViewModel: UserViewModel) {
        let viewController = EmployeesViewController(userViewModel: userViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func routeToInfoScreen(userViewModel: UserViewModel) {
        let viewController = InfoViewController(userViewModel: userViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func routeToColorsScreen(userViewModel: UserViewModel) {
        let viewController = ColorsViewController(userViewModel: userViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func routeToReviewScreen(userViewModel: UserViewModel) {
        let viewController = ReviewController(userViewModel: userViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func routeToResultScreen(userViewModel: UserViewModel) {
        let viewController = ResultViewController(userViewModel: userViewModel)
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.present(viewController, animated: true)
    }
    
    func popToViewControllerType(_ viewControllerType: UIViewController.Type) {
        guard let navigationController = self.navigationController else { return }
        
        for controller in navigationController.viewControllers {
            if type(of: controller) == viewControllerType {
                navigationController.popToViewController(controller, animated: true)
                if let presentedViewController = navigationController.presentedViewController {
                    presentedViewController.dismiss(animated: true)
                }
                break
            }
        }
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}
