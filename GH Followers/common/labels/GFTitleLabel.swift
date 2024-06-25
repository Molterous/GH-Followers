//
//  GFTitleLabel.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 18/04/24.
//

import UIKit

class GFTitleLabel: UILabel {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // custom init
    init(textAlignment: NSTextAlignment, textSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font          = UIFont.systemFont(ofSize: textSize, weight: .bold)
        configure()
    }
    
    
    // configure label
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
    }
}
