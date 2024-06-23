//
//  UserInfoVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 26/05/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    // resume from 8:20
    
    var userName: String!
    
    let headerView          = UIView()
    let reposItemView       = UIView()
    let followersItemView   = UIView()

    
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
                    DispatchQueue.main.async {
                        self.addChildVC(with: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    }
                    break
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
                    break
            }
            
        }
    }
    
    
    func layoutUI() {
        
        let padding: CGFloat = 20
        
        view.addSubview(headerView)
        view.addSubview(reposItemView)
        view.addSubview(followersItemView)
        
        
        headerView.translatesAutoresizingMaskIntoConstraints        = false
        reposItemView.translatesAutoresizingMaskIntoConstraints     = false
        followersItemView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            
            reposItemView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            reposItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            reposItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            reposItemView.heightAnchor.constraint(equalToConstant: 140),
            
            
            followersItemView.topAnchor.constraint(equalTo: reposItemView.bottomAnchor, constant: padding),
            followersItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            followersItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            followersItemView.heightAnchor.constraint(equalToConstant: 140)
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
