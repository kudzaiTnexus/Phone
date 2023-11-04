//
//  InfoViewController.swift
//  Phone
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
import UIKit
import Combine

class InfoViewController: BaseViewController {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = Resolver.resolve(dependency: Router.self)
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Choose Gender"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Male", "Female", "Other"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = userViewModel.viewState.selectedGender
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
    }()
    
    private lazy var residentialAddress: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Residential Adress"
        textfield.borderStyle = .roundedRect
        textfield.layer.cornerRadius = 4.0
        textfield.layer.borderWidth = 1.0
        textfield.layer.borderColor = UIColor.gray.cgColor
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self, action: #selector(residentialAddressChanged), for: .editingChanged)
        
        return textfield
    }()
    
    private lazy var cardView: CardUIView = {
        let cardView = CardUIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        cardView.showTitle = true
        cardView.showChevron = true
        cardView.showCircle = true
        cardView.title = "Select Employee preffered color"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        cardView.addGestureRecognizer(tapGesture)
        cardView.isUserInteractionEnabled = true
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        return cardView
    }()
    
    private lazy var stackView: UIStackView = {
        let  stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

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
        
        title = "Additional Info"
        
        setupNavigationBarButton()
        setBackNavigation()
        setupBinding()
        
        residentialAddress.text = userViewModel.viewState.residentialAddress
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    func setupViews() {
        self.view.backgroundColor = .white
        
        stackView.alignment = .center
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(segmentedControl)
        
        view.addSubview(stackView)
        view.addSubview(cardView)
        view.addSubview(residentialAddress)

        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/1.5),
            
            cardView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 80),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            residentialAddress.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 32),
            residentialAddress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            residentialAddress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupBinding() {
        userViewModel.$viewState
            .sink(receiveValue: { [weak self] state in
                guard let self = self else { return }
               
                if state.isColorsLoading {
                   // reductedState
                } else {
                    let colorData = state.selectedColor ??
                    state.colorsData.first
                    
                    cardView.circleColor = colorData?.color ?? ""
                    cardView.infoArray = [colorData?.name ?? ""]
                    cardView.updateUI()
                }
            })
            .store(in: &cancellables)
    }
    
    @objc func cardTapped() {
        router.routeToColorsScreen(userViewModel: userViewModel)
    }

    @objc override func nextButtonTapped() {
        router.routeToReviewScreen(userViewModel: userViewModel)
    }
    
    @objc func segmentedControlValueChanged(sender: UISegmentedControl) {
        userViewModel.viewState.selectedGender = sender.selectedSegmentIndex
    }

    @objc func residentialAddressChanged(_ textField: UITextField) {
        userViewModel.viewState.residentialAddress = textField.text ?? ""
    }
}
