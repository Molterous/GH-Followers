//
//  UserInfoVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 26/05/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor                = .systemBackground
        
        let doneBtn                         = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = doneBtn
    }

    
    @objc func dismissVC() { dismiss(animated: true) }
}
