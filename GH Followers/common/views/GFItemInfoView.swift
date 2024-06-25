//
//  GFItemInfoView.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 25/06/24.
//

import UIKit

class GFItemInfoView: UIView {

    let symbolIV    = UIImageView()
    let titleLabel  = GFTitleLabel(textAlignment: .left, textSize: 14)
    let countLabel  = GFTitleLabel(textAlignment: .center, textSize: 14)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // sets the layout constraints
    private func configure() {
        addSubview(symbolIV)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolIV.translatesAutoresizingMaskIntoConstraints = false
        symbolIV.contentMode    = .scaleAspectFit
        symbolIV.tintColor      = .label
        
        NSLayoutConstraint.activate([
            symbolIV.topAnchor.constraint(equalTo: self.topAnchor),
            symbolIV.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolIV.widthAnchor.constraint(equalToConstant: 20),
            symbolIV.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolIV.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolIV.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolIV.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: symbolIV.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: symbolIV.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    
    // used to update labels and image data
    func setType(for item: InfoTypeEnum, with count: Int) {
        
        switch item {
            
            case .gists:
                symbolIV.image  = UIImage(systemName: SfSymbols.gists)
                titleLabel.text = "Public Gists"
                break
            
            case .repos:
                symbolIV.image  = UIImage(systemName: SfSymbols.repos)
                titleLabel.text = "Public Repos"
                break
            
            case .followers:
                symbolIV.image  = UIImage(systemName: SfSymbols.followers)
                titleLabel.text = "Followers"
                break
            
            default:
                symbolIV.image  = UIImage(systemName: SfSymbols.followings)
                titleLabel.text = "Followings"
                break
        }
        
        countLabel.text = String(count)
    }
}
