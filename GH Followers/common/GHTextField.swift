//
//  GHTextField.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 09/04/24.
//

import UIKit

class GHTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(placeHolderText: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(placeHolderText: String?) {
        super.init(frame: .zero)
        configure(placeHolderText: placeHolderText)
    }
    
    
    private func configure(placeHolderText: String?) {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        placeholder                 = placeHolderText ?? "Enter a username"
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        returnKeyType               = .go
    }
}
