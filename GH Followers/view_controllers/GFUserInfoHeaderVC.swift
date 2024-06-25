//
//  GFUserInfoHeaderVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 17/06/24.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    let avatarIV        = GFAvatarIV(frame: .zero)
    let locationIV      = UIImageView()
    let userNameLabel   = GFTitleLabel(textAlignment: .left, textSize: 34)
    let nameLabel       = GFSecondaryTitleLabel(fontSize: 18)
    let locationLabel   = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel        = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    
    init(user: User!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        layoutUi()
        configureUi()
    }
    
    
    func addSubviews() {
        view.addSubview(avatarIV)
        view.addSubview(locationIV)
        view.addSubview(userNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
        
        locationIV.translatesAutoresizingMaskIntoConstraints = false
    }

    
    func layoutUi() {
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        
        NSLayoutConstraint.activate([
            avatarIV.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarIV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarIV.widthAnchor.constraint(equalToConstant: 90),
            avatarIV.heightAnchor.constraint(equalToConstant: 90),
            
            userNameLabel.topAnchor.constraint(equalTo: avatarIV.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarIV.trailingAnchor, constant: textImagePadding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarIV.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationIV.bottomAnchor.constraint(equalTo: avatarIV.bottomAnchor),
            locationIV.leadingAnchor.constraint(equalTo: avatarIV.trailingAnchor, constant: textImagePadding),
            locationIV.widthAnchor.constraint(equalToConstant: 20),
            locationIV.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationIV.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationIV.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarIV.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarIV.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    
    func configureUi() {
        avatarIV.downloadImage(from: user.avatarUrl)
        
        userNameLabel.text      = user.login
        nameLabel.text          = user.name ?? ""
        locationLabel.text      = user.location ?? "no location data"
        
        bioLabel.text           = user.bio ?? "no bio available"
        bioLabel.numberOfLines  = 3
        
        locationIV.image        = UIImage(systemName: "mappin.and.ellipse")
        locationIV.tintColor    = .secondaryLabel
    }
}
