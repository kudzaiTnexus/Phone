//
//  CardUIView.swift
//  Phone
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
import UIKit
import Kingfisher 
import SwiftUI

class CardUIView: UIView {
    
    var showTitle: Bool = false
    var showChevron: Bool = false
    var showCircle: Bool = false
    var title: String = ""
    var avatar: String = ""
    var circleColor: String = ""
    var infoArray: [String] = []
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private let avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.kf.indicatorType = .activity
        return avatarImageView
    }()

    private lazy var avatarContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.3
        view.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return view
    }()

    private lazy var horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.addArrangedSubview(.horizontalSpacer(width: 8))
        horizontalStackView.addArrangedSubview(avatarContainerView)
        horizontalStackView.addArrangedSubview(infoStackView)
        horizontalStackView.addArrangedSubview(UIView())
        horizontalStackView.addArrangedSubview(chevronImageView)
        horizontalStackView.addArrangedSubview(.horizontalSpacer(width: 8))
        horizontalStackView.alignment = .center
        
        return horizontalStackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical

        // Gray divider line
        let divider1 = UIView()
        divider1.backgroundColor = .gray
        divider1.heightAnchor.constraint(equalToConstant: 0.3).isActive = true

        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(divider1)
        mainStackView.setCustomSpacing(16, after: divider1)
        mainStackView.addArrangedSubview(horizontalStackView)
        mainStackView.setCustomSpacing(16, after: horizontalStackView)
        // Gray divider line
        let divider2 = UIView()
        divider2.backgroundColor = .gray
        divider2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        mainStackView.addArrangedSubview(divider2)

        return mainStackView
    }()

    
    private let infoStackView: UIStackView = {
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.spacing = 4
        return infoStackView
    }()
    
    private let chevronImageView: UIImageView = {
        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
        chevronImageView.tintColor = .gray
        chevronImageView.contentMode = .scaleAspectFit
        return chevronImageView
    }()
    
    private let circleView: UIView = {
        let circleView = UIView()
        circleView.layer.cornerRadius = 15
        return circleView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {

        addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func updateUI() {
        
        resetUI()
        
        titleLabel.text = title
        titleLabel.isHidden = !showTitle
        
        if showCircle {
            avatarImageView.addSubview(circleView)
            
            circleView.backgroundColor = UIColor(hex: circleColor)
            circleView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            circleView.layer.cornerRadius = 20

        } else {
            if let url = URL(string: avatar) {
                avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            }
        }
        
        infoArray.forEach { text in
            let label = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            label.textColor = .black
            infoStackView.addArrangedSubview(label)
        }
        
        chevronImageView.isHidden = !showChevron
    }
    
    func resetUI() {
        titleLabel.text = nil
        avatarImageView.image = UIImage(named: "placeholder")
        infoStackView.subviews.forEach {
            infoStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        circleView.removeFromSuperview()
        chevronImageView.isHidden = true
    }

}

extension UIView {
    static func horizontalSpacer(width: CGFloat) -> UIView {
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.widthAnchor.constraint(equalToConstant: width).isActive = true
        return spacerView
    }
    
    static func verticalSpacer(height: CGFloat) -> UIView {
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.heightAnchor.constraint(equalToConstant: height).isActive = true
        return spacerView
    }
}
