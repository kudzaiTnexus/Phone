//
//  HomeViewController.swift
//  Phone
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
import UIKit
import Combine

class HomeViewController: BaseViewController {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = Resolver.resolve(dependency: Router.self)

    private var dobButton: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Date of Birth"
        textfield.borderStyle = .roundedRect
        textfield.layer.cornerRadius = 4.0
        textfield.layer.borderWidth = 1.0
        textfield.layer.borderColor = UIColor.gray.cgColor
        return textfield
    }()
    
    private var placeOfBirthTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Place of Birth"
        textfield.borderStyle = .roundedRect
        textfield.layer.cornerRadius = 4.0
        textfield.layer.borderWidth = 1.0
        textfield.layer.borderColor = UIColor.gray.cgColor
        textfield.addTarget(self, action: #selector(placeOfBirthChanged), for: .editingChanged)
        return textfield
    }()
    
    let datePicker = UIDatePicker()
    
    private lazy var cardView: CardUIView = {
        let cardView = CardUIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        cardView.showTitle = true
        cardView.showChevron = true
        cardView.showCircle = false
        cardView.title = "Select an Employee"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        cardView.addGestureRecognizer(tapGesture)
        cardView.isUserInteractionEnabled = true
        
        return cardView
    }()

    // ViewModel
    var userViewModel: UserViewModel
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
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
        hideBackButton()
        
        title = "Employee"
        
        setupNavigationBarButton()
        setupBinding()
        
        placeOfBirthTextField.text = userViewModel.viewState.placeOfBirth
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    func setupViews() {
        self.view.backgroundColor = .white
    
        view.addSubview(cardView)
        
        view.addSubview(dobButton)
        view.addSubview(placeOfBirthTextField)

        // Layout using Auto Layout
        dobButton.translatesAutoresizingMaskIntoConstraints = false
        placeOfBirthTextField.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            dobButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 32),
            dobButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dobButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            placeOfBirthTextField.topAnchor.constraint(equalTo: dobButton.bottomAnchor, constant: 16),
            placeOfBirthTextField.leadingAnchor.constraint(equalTo: dobButton.leadingAnchor),
            placeOfBirthTextField.trailingAnchor.constraint(equalTo: dobButton.trailingAnchor),
        ])
    }
    
    func setupBinding() {
        userViewModel.$viewState
            .sink(receiveValue: { [weak self] state in
                guard let self = self else { return }
               
                if state.isEmployeesLoading {
                   // reductedState
                } else {
                     let employeeData = state.selectedEmployee ?? state.employees.first
                    
                    cardView.avatar = employeeData?.avatar ?? ""
                    cardView.infoArray = [
                        employeeData?.firstName ?? "",
                        employeeData?.email ?? ""
                    ]
                    cardView.updateUI()
                }
            })
            .store(in: &cancellables)
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
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let selectedDate = dateFormatter.string(from: datePicker.date)
//        userViewModel.viewState.dateOfBirth = selectedDate
//        dobButton.setTitle(selectedDate, for: .normal)
    }
    
    @objc func cardTapped() {
        router.routeToEmployeesScreen(userViewModel: userViewModel)
    }

    @objc override func nextButtonTapped() {
        router.routeToInfoScreen(userViewModel: userViewModel)
    }

    @objc func placeOfBirthChanged(_ textField: UITextField) {
        userViewModel.viewState.placeOfBirth = textField.text ?? ""
    }
}
