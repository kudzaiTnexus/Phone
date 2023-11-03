//
//  CardUIView.swift
//  Phone
//
//  Created by KudzaisheMhou on 03/11/2023.
//

import Foundation
import UIKit
import Kingfisher 

class CardUIView: UIView {
    
    var showTitle: Bool = false
    var showChevron: Bool = false
    var showCircle: Bool = false
    var title: String = ""
    var avatar: String = ""
    var circleColor: UIColor = .white
    var infoArray: [String] = []
    
    private let titleLabel = UILabel()
    private let avatarImageView = UIImageView()
    private let infoStackView = UIStackView()
    private let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
    private let circleView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // titleLabel setup
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .black
        
        // avatarImageView setup
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 8
        avatarImageView.clipsToBounds = true
        avatarImageView.kf.indicatorType = .activity
        
        // circleView setup
        circleView.layer.cornerRadius = 15
        
        // chevronImageView setup
        chevronImageView.tintColor = .gray
        chevronImageView.contentMode = .scaleAspectFit
        
        // infoStackView setup
        infoStackView.axis = .vertical
        infoStackView.spacing = 4
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.addArrangedSubview(avatarImageView)
        horizontalStackView.addArrangedSubview(infoStackView)
        horizontalStackView.addArrangedSubview(chevronImageView)
        horizontalStackView.alignment = .center
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(horizontalStackView)
        
        addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    func updateUI() {
        titleLabel.text = title
        titleLabel.isHidden = !showTitle
        
        if showCircle {
            circleView.backgroundColor = circleColor
            avatarImageView.addSubview(circleView)
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
}
