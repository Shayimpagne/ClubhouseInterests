//
//  InterestView.swift
//  ClubhouseAnimation
//
//  Created by Emir on 24.02.2021.
//

import Foundation
import UIKit

class InterestView: UIView {
    private var emojiLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.96, alpha: 1)
        
        addSubview(stackView)
        stackView.addArrangedSubview(emojiLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.bindToSuperview(8)
        
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        emojiLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = 12
    }
    
    func setup(emoji: String, title: String) {
        emojiLabel.text = emoji
        titleLabel.text = title
    }
}
