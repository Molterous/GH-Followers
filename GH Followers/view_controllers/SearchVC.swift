//
//  SearchVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 03/04/24.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoIV      = UIImageView()
    let usernameTF  = GHTextField()
    let searchBtn   = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var isUserNameValid : Bool { return !(usernameTF.text ?? "").isEmpty }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureIV()
        configureTF()
        configureButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowerListVC() {
        
        guard isUserNameValid else {
            presentGFAlertOnMainThread(title: "Empty username", message: "Please enter a username. We need to know whome to search for.", buttonTitle: "Okay")
            return
        }
        
        let followerListVC = FollowersListVC()
        followerListVC.userName = usernameTF.text
        followerListVC.title = usernameTF.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func configureIV() {
        view.addSubview(logoIV)
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        logoIV.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoIV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoIV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoIV.heightAnchor.constraint(equalToConstant: 200),
            logoIV.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    
    func configureTF() {
        view.addSubview(usernameTF)
        usernameTF.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTF.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 45),
            usernameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTF.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    func configureButton() {
        view.addSubview(searchBtn)
        searchBtn.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
