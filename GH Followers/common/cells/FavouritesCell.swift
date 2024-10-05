//
//  FavouritesCell.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 29/09/24.
//

import UIKit

class FavouritesCell: UITableViewCell {
    static let reUseId = "FavouritesCell"
    
    let avatarIV            = GFAvatarIV(frame: .zero)
    let userNameLabel       = GFTitleLabel(textAlignment: .left, textSize: 26)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(fav: Follower) {
        userNameLabel.text = fav.login
        avatarIV.downloadImage(from: fav.avatarUrl)
    }
    
    
    private func configure() {
        addSubview(avatarIV)
        addSubview(userNameLabel)
        
        accessoryType           = .disclosureIndicator
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            avatarIV.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarIV.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarIV.heightAnchor.constraint(equalToConstant: 60),
            avatarIV.widthAnchor.constraint(equalToConstant: 60),
            
            userNameLabel.centerYAnchor.constraint(equalTo: avatarIV.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarIV.trailingAnchor, constant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
