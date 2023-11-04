//
//  EmployeesViewController.swift
//  Phone
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
import UIKit
import Combine

class EmployeesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()  
        tableView.separatorStyle = .none
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: "EmployeeCell")
        return tableView
    }()
    
    private var cancellables: Set<AnyCancellable> = []

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
        
        view.addSubview(tableView)
        
        setBackNavigation()
        setupBinding()
        setupView()
        
        title = "LIST OF EMPLOYEES"
    }
    
    func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }
    
    func setupBinding() {
        userViewModel.$viewState
            .sink(receiveValue: { [weak self] state in
                guard let self = self else { return }
               
                if state.isEmployeesLoading {
                   // reductedState
                } else {
                    tableView.reloadData()
                }
            })
            .store(in: &cancellables)
    }
    
    @objc private func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.viewState.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
        let employee = userViewModel.viewState.employees[indexPath.row]
        cell.configure(with: employee)
        return cell
    }
    
    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employee = userViewModel.viewState.employees[indexPath.row]
        userViewModel.intent(.selectEmployee(employee))
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

}

class EmployeeCell: UITableViewCell {
    
    private let cardView: CardUIView = {
        let cardView = CardUIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        cardView.showTitle = false
        cardView.showChevron = false
        cardView.showCircle = false
        return cardView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       addSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with employee: UserData) {
        cardView.avatar = employee.avatar ?? ""
        cardView.infoArray = [
        employee.firstName ?? "",
        employee.email ?? ""
    ]
        cardView.updateUI()
    }
}
