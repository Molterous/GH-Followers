//
//  UiHelper.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 19/05/24.
//

import UIKit

class UiHelper {
    
    static func configureThreeColumnFlowLayout(in view: UIView)-> UICollectionViewFlowLayout {
        
        let width                           = view.bounds.width
        let padding: CGFloat                = 12
        let minimumItemSpacing: CGFloat     = 10
        let availableWidth                  = width - ( padding * 2 ) - ( minimumItemSpacing * 2 )
        let itemWidth                       = availableWidth / 3
        
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                 = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
