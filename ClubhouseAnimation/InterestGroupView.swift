//
//  InterestGroupView.swift
//  ClubhouseAnimation
//
//  Created by Emir on 24.02.2021.
//

import Foundation
import UIKit

class InterestGroupView: UIView {
    private var groupStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var rows = [UIScrollView]()
    private var minRowWidth: CGFloat = 0
    private var minRowOffset: CGFloat = 0
    
    init() {
        super.init(frame: .zero)
        
        addSubview(groupStackView)
        groupStackView.bindToSuperview()
        
        addSubview(scrollView)
        scrollView.addSubview(transparentView)
        scrollView.bindToSuperview()
        transparentView.bindToSuperview()
        transparentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard
            let minGroupView = rows.filter({ $0.contentSize.width > bounds.width }).min(by: { $0.contentSize.width < $1.contentSize.width })
        else { return }
        
        minRowWidth = minGroupView.contentSize.width
        minRowOffset = minRowWidth - bounds.width
        transparentView.widthAnchor.constraint(equalToConstant: minRowWidth).isActive = true
    }
    
    func setup(with group: InterestsGroup) {
        group.items.forEach { interests in
            let stackView = UIStackView()
            stackView.spacing = 8
            stackView.axis = .horizontal

            interests.forEach { interest in
                let view = InterestView()
                view.setup(emoji: interest.emoji, title: interest.title)
                stackView.addArrangedSubview(view)
            }

            let scrollView = UIScrollView()
            scrollView.addSubview(stackView)
            scrollView.isUserInteractionEnabled = false
            stackView.bindToSuperview()
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true

            rows.append(scrollView)
            groupStackView.addArrangedSubview(scrollView)
        }
        
        layoutIfNeeded()
    }
}

extension InterestGroupView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView.contentOffset.x {
        case let x where x < 0:
            for row in rows {
                row.contentOffset.x = scrollView.contentOffset.x
            }
        case let x where x > minRowOffset:
            let minRowVisibleWidth = minRowWidth - scrollView.contentOffset.x

            for row in rows {
                let velocity = row.contentSize.width > bounds.width ?
                (row.contentSize.width - bounds.width) / minRowOffset : 1
                let offset = scrollView.contentOffset.x * velocity
                let currentRowVisibleWidth = row.contentSize.width - offset
                let overtakenDistance = minRowVisibleWidth - currentRowVisibleWidth
                row.contentOffset.x = offset - overtakenDistance
            }
        default:
            for row in rows {
                let velocity = row.contentSize.width > bounds.width ?
                (row.contentSize.width - bounds.width) / minRowOffset : 1
                let offset = scrollView.contentOffset.x * velocity
                row.contentOffset.x = offset
            }
        }
    }
}

extension UIView {
    func bindToSuperview(_ padding: CGFloat = 0) {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor, constant: padding).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding).isActive = true
    }
}
