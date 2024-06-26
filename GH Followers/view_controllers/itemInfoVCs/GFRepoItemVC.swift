//
//  GFRepoItemVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 25/06/24.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureItems()
    }
 
    
    private func configureItems() {
        itemInfoViewOne.setType(for: .repos, with: user.publicRepos)
        itemInfoViewTwo.setType(for: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    
    override func actionButtonTapped() { delegate.didTapGithubProfile(for: user) }
}
