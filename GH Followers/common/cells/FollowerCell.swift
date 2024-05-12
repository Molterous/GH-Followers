//
//  FollowerCell.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 03/05/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reUseId = "FollowerCell"
    
    let avatarIV            = GFAvatarIV(frame: .zero)
    let userNameLabel       = GFTitleLabel(textAlignment: .center, textSize: 16)
    let padding: CGFloat    = 8
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower) {
        userNameLabel.text = follower.login
        
    }
    
    
    private func configure() {
        addSubview(avatarIV)
        addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            avatarIV.topAnchor.constraint       (equalTo: topAnchor,        constant: padding),
            avatarIV.leadingAnchor.constraint   (equalTo: leadingAnchor,    constant: padding),
            avatarIV.trailingAnchor.constraint  (equalTo: trailingAnchor,   constant: -padding),
            avatarIV.heightAnchor.constraint    (equalTo: avatarIV.widthAnchor),
            
            userNameLabel.topAnchor.constraint       (equalTo: avatarIV.bottomAnchor,   constant: 12),
            userNameLabel.leadingAnchor.constraint   (equalTo: leadingAnchor,           constant: padding),
            userNameLabel.trailingAnchor.constraint  (equalTo: trailingAnchor,          constant: -padding),
            userNameLabel.heightAnchor.constraint    (equalToConstant: 20),
        ])
    }
}
