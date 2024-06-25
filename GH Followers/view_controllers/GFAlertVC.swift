//
//  GFAlertVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 18/04/24.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let containerView   = UIView()
    let titleLabel      = GFTitleLabel(textAlignment: .center, textSize: 20)
    let bodyLabel       = GFBodyLabel(textAlignment: .center)
    let submitBtn       = GFButton(backgroundColor: .systemPink, title: "OK")
    let contentPadding  : CGFloat  = 20

    var alertTitle  : String?
    var message     : String?
    var buttonText  : String?
    
    
    init(alertTitle: String, message: String, buttonText: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = alertTitle
        self.message    = message
        self.buttonText = buttonText
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureContainerView()
        configureTitleLabel()
        configureSubmitBtn()
        configureBodyLabel()
    }
    
    
    func configureContainerView() {
        view.addSubview(containerView)
        
        containerView.backgroundColor    = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth  = 2
        containerView.layer.borderColor  = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
    
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"

        NSLayoutConstraint.activate([
            titleLabel.topAnchor        .constraint(equalTo: containerView.topAnchor,       constant:  contentPadding),
            titleLabel.leadingAnchor    .constraint(equalTo: containerView.leadingAnchor,   constant:  contentPadding),
            titleLabel.trailingAnchor   .constraint(equalTo: containerView.trailingAnchor,  constant: -contentPadding),
            titleLabel.heightAnchor     .constraint(equalToConstant: 28),
        ])
    }
    
    
    func configureSubmitBtn() {
        containerView.addSubview(submitBtn)
        submitBtn.setTitle(buttonText ?? "OK", for: .normal)
        submitBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            submitBtn.bottomAnchor     .constraint(equalTo: containerView.topAnchor,       constant: -contentPadding),
            submitBtn.leadingAnchor    .constraint(equalTo: containerView.leadingAnchor,   constant:  contentPadding),
            submitBtn.trailingAnchor   .constraint(equalTo: containerView.trailingAnchor,  constant: -contentPadding),
            submitBtn.heightAnchor     .constraint(equalToConstant: 44),
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    func configureBodyLabel() {
        containerView.addSubview(bodyLabel)
        bodyLabel.text          = message ?? "Unable to complete Request"
        bodyLabel.numberOfLines = 4
        

        NSLayoutConstraint.activate([
            bodyLabel.topAnchor        .constraint(equalTo: titleLabel.bottomAnchor,       constant: 8),
            bodyLabel.leadingAnchor    .constraint(equalTo: containerView.leadingAnchor,   constant:  contentPadding),
            bodyLabel.trailingAnchor   .constraint(equalTo: containerView.trailingAnchor,  constant: -contentPadding),
            bodyLabel.topAnchor        .constraint(equalTo: submitBtn.topAnchor,           constant: -12),
        ])
    }
}
