//
//  GFButton.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 25/06/24.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
    // custom init
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        set(backgroundColor: backgroundColor, title: title)
        configure()
    }
    
    
    // configures the btn
    private func configure() {
        layer.cornerRadius                          = 10
        titleLabel?.font                            = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints   = false
        setTitleColor(.white, for: .normal)
    }

    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
}
