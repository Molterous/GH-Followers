//
//  GFEmptyStateView.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 26/05/24.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, textSize: 28)
    let logoIV       = UIImageView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // custom error messgae init
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    
    // congfigure empty state image view
    func configure() {
        addSubview(messageLabel)
        addSubview(logoIV)
        
        messageLabel.numberOfLines   = 3
        messageLabel.textColor       = .secondaryLabel
        
        logoIV.image                = UIImage(named: "empty-state-logo")
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(  equalTo: self.centerYAnchor,   constant: -150),
            messageLabel.leadingAnchor.constraint(  equalTo: self.leadingAnchor,   constant: 40),
            messageLabel.trailingAnchor.constraint( equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoIV.widthAnchor.constraint(    equalTo: self.widthAnchor,    multiplier: 1.3),
            logoIV.heightAnchor.constraint(   equalTo: self.heightAnchor,   multiplier: 1.3),
            logoIV.trailingAnchor.constraint( equalTo: self.trailingAnchor, constant: 170),
            logoIV.bottomAnchor.constraint(   equalTo: self.bottomAnchor,   constant: 40),
            
        ])
    }
}
