//
//  HomeViewController.swift
//  Phone
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {

    // UI Components
    let usernameTextField = UITextField()
    let dobButton = UIButton(type: .system)
    let placeOfBirthTextField = UITextField()
    let nextButton = UIButton(type: .system)
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    let datePicker = UIDatePicker()

    // ViewModel
    var userViewModel: UserViewModel
    
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        hideBackButton()
        
        title = "Employee"
    }

    func setupViews() {
        self.view.backgroundColor = .white

        usernameTextField.placeholder = "Username"
        view.addSubview(usernameTextField)
        
        dobButton.setTitle("Date of Birth", for: .normal)
        dobButton.addTarget(self, action: #selector(dobButtonTapped), for: .touchUpInside)
        view.addSubview(dobButton)
        
        placeOfBirthTextField.placeholder = "Place of Birth"
        view.addSubview(placeOfBirthTextField)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        view.addSubview(nextButton)
        
        view.addSubview(activityIndicator)

        // Layout using Auto Layout
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        dobButton.translatesAutoresizingMaskIntoConstraints = false
        placeOfBirthTextField.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            dobButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            dobButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            dobButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            
            placeOfBirthTextField.topAnchor.constraint(equalTo: dobButton.bottomAnchor, constant: 16),
            placeOfBirthTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            placeOfBirthTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            
            nextButton.topAnchor.constraint(equalTo: placeOfBirthTextField.bottomAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func dobButtonTapped() {
        // Display DatePicker
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        let alertController = UIAlertController(title: "Select Date of Birth", message: "\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alertController.view.addSubview(datePicker)
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            self.datePickerValueChanged()
        }
        alertController.addAction(doneAction)
        present(alertController, animated: true)
    }

    @objc func datePickerValueChanged() {
        // Format the date from datePicker
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        userViewModel.viewState.dateOfBirth = selectedDate
        dobButton.setTitle(selectedDate, for: .normal)
    }

    @objc func nextButtonTapped() {
        // Logic for next button tap
        // Maybe navigate to another view controller
    }

    func bindViewModel() {
        // For the sake of example, using NotificationCenter as binding mechanism.
        // In a real-world scenario, you might use Combine, Delegation, or other mechanisms.
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoadingChange), name: NSNotification.Name("isEmployeesLoadingChanged"), object: nil)
    }
    
    @objc func handleLoadingChange() {
        if userViewModel.viewState.isEmployeesLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
