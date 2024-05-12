//
//  FollowersListVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 18/04/24.
//

import UIKit

class FollowersListVC: UIViewController {

    enum Section { case main }
    
    
    var userName: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    // todo: resume from here
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCollectionView()
        getFollowers()
    }
    
    
    func configureVC() {
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func getFollowers() {
        NetworkManager.shared.getFolower(for: userName, page: 1) { result in
            
            switch result {
                case .success(let followers):
                    print(followers)
                    break
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
                    break
            }
            
        }
    }
    
    
    func configureThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        
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
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reUseId)
    }
}
