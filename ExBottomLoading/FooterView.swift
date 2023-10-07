//
//  FooterView.swift
//  ExBottomLoading
//
//  Created by 김종권 on 2023/10/07.
//

import UIKit

final class FooterView: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            indicatorView.topAnchor.constraint(equalTo: topAnchor),
        ])
        
        indicatorView.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
