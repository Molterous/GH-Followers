//
//  GFFollowerItemVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 26/06/24.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureItems()
    }
 
    
    private func configureItems() {
        itemInfoViewOne.setType(for: .followers, with: user.followers)
        itemInfoViewTwo.setType(for: .followings, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonTapped() { delegate.didTapGetFollowers(for: user) }
}
