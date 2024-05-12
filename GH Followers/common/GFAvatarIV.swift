//
//  GFAvatarIV.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 03/05/24.
//

import UIKit

class GFAvatarIV: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        layer.cornerRadius  = 16
        clipsToBounds       = true
        image               = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
