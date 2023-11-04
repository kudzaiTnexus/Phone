//
//  ReviewController .swift
//  Phone
//
//  Created by KudzaisheMhou on 04/11/2023.
//

import Foundation
import UIKit
import Combine

class ReviewController: BaseViewController {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = Resolver.resolve(dependency: Router.self)
    
    private lazy var cardView: CardUIView = {
        let cardView = CardUIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        cardView.showTitle = true
        cardView.showChevron = false
        cardView.showCircle = false
        cardView.title = "Personal details"
        
        return cardView
    }()
    
    private lazy var submitButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 4
        button.tintColor = .white
        button.backgroundColor = .blue
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical

        // Header HStack
        let headerStackView = UIStackView()
        headerStackView.axis = .horizontal

        let headerLabel = UILabel()
        headerLabel.text = "Additional Infomation"
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        headerLabel.textColor = .black
        headerStackView.addArrangedSubview(headerLabel)
        headerStackView.addArrangedSubview(UIView())  // acts as Spacer()

        // Data HStack
        let dataStackView = UIStackView()
        dataStackView.axis = .horizontal
        dataStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)  // padding for horizontal
        dataStackView.isLayoutMarginsRelativeArrangement = true

        let infoVStack = UIStackView()
        infoVStack.axis = .vertical
        infoVStack.spacing = 4

        let colorLabel = UILabel()
        colorLabel.text = userViewModel.viewState.selectedColor?.name ?? ""
        colorLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        colorLabel.textColor = .black
        infoVStack.addArrangedSubview(colorLabel)

        let birthPlaceLabel = UILabel()
        birthPlaceLabel.text = userViewModel.viewState.placeOfBirth
        birthPlaceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        birthPlaceLabel.textColor = .black
        infoVStack.addArrangedSubview(birthPlaceLabel)

        let addressLabel = UILabel()
        addressLabel.text = userViewModel.viewState.residentialAddress
        addressLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        addressLabel.textColor = .black
        infoVStack.addArrangedSubview(addressLabel)

        dataStackView.addArrangedSubview(infoVStack)
        dataStackView.addArrangedSubview(UIView())  // acts as Spacer()

        mainStackView.addArrangedSubview(headerStackView)
        mainStackView.addArrangedSubview(dataStackView)

        return mainStackView
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
        
        title = "Review"
        
        setBackNavigation()
        configureView()
        
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupBinding() {
        userViewModel.$viewState
            .sink(receiveValue: { [weak self] state in
                guard let self else { return }
                if state.showSuccessView {
                    router.routeToResultScreen(userViewModel: self.userViewModel)
                }
            })
            .store(in: &cancellables)
    }
    
    func setupViews() {
        self.view.backgroundColor = .white
    
        view.addSubview(cardView)
        view.addSubview(mainStackView)
        view.addSubview(submitButton)

        cardView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
            mainStackView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    func configureView() {

        cardView.avatar = userViewModel.viewState.selectedEmployee?.avatar ?? ""
        cardView.infoArray = [
        (userViewModel.viewState.selectedEmployee?.firstName ?? "" + (userViewModel.viewState.selectedEmployee?.lastName ?? "")),
        userViewModel.viewState.selectedEmployee?.email ?? "",
        userViewModel.viewState.dateOfBirth,
        userViewModel.viewState.gender
    ]
        cardView.updateUI()
    }

    @objc func submitButtonTapped() {
        userViewModel.intent(.teamMembers)
    }

}
