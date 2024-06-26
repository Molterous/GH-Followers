//
//  UserInfoVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 26/05/24.
//

import UIKit
import SafariServices


protocol UserInfoVCDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}


class UserInfoVC: UIViewController {
    
    // resume from 8:20
    
    var userName: String!
    
    let headerView          = UIView()
    let reposItemView       = UIView()
    let followersItemView   = UIView()
    let dateLabel           = GFBodyLabel(textAlignment: .center)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor                = .systemBackground
        
        let doneBtn                         = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = doneBtn
        
        layoutUI()
        getUser(for: userName)
    }
    
    
    func getUser(for userName: String) {
        //            do this to show warning, works same as todo in android studio
        //            #warning("Dismiss Loading View")
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            dismissLoadingView()
            
            switch result {
                case .success(let user):
                DispatchQueue.main.async { self.configureUI(with: user) }
                    break
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
                    break
            }
            
        }
    }
    
    
    func configureUI(with user: User) {
        let repoItemVC      = GFRepoItemVC(user: user);
        repoItemVC.delegate = self
        
        let followerItemVC      = GFFollowerItemVC(user: user);
        followerItemVC.delegate = self
        
        self.addChildVC(with: GFUserInfoHeaderVC(user: user),   to: self.headerView)
        self.addChildVC(with: repoItemVC,                       to: self.reposItemView)
        self.addChildVC(with: followerItemVC,                   to: self.followersItemView)
        self.dateLabel.text = "GitHub user since: \(user.createdAt.convertDateToDisplayFormat())"
    }
    
    
    func layoutUI() {
        
        let padding: CGFloat = 20
        let largePadding: CGFloat = 40
        
        view.addSubview(headerView)
        view.addSubview(reposItemView)
        view.addSubview(followersItemView)
        view.addSubview(dateLabel)
        
        
        headerView.translatesAutoresizingMaskIntoConstraints        = false
        reposItemView.translatesAutoresizingMaskIntoConstraints     = false
        followersItemView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            
            reposItemView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: largePadding),
            reposItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            reposItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            reposItemView.heightAnchor.constraint(equalToConstant: 140),
            
            
            followersItemView.topAnchor.constraint(equalTo: reposItemView.bottomAnchor, constant: padding),
            followersItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            followersItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            followersItemView.heightAnchor.constraint(equalToConstant: 140),
            
            
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -largePadding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func addChildVC(with childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    
    @objc func dismissVC() { dismiss(animated: true) }
}


extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGithubProfile(for user: User) {
        
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(
                title: "Invalid URL",
                message: "The url attached to this user is invalid",
                buttonTitle: "OK"
            )
            return
        }
        
        showSafariVC(with: url)
    }
    
    
    func didTapGetFollowers(for user: User) {
        
    }
}
