//
//  FollowersListVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 18/04/24.
//

import UIKit

class FollowersListVC: UIViewController {

    // resume from 5:50:34.
    enum Section { case main }
    
    
    var userName: String!
    var page                = 1
    var hasMoreFollowers    = true
    var isSearching         = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers:      [Follower]  = []
    var filterFollower: [Follower]  = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        cofigureSearchController()
        configureCollectionView()
        getFollowers(for: userName, at: page)
        configureDataSource()
    }
    
    
    func configureVC() {
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func getFollowers(for userName: String, at page: Int) {
        //            do this to show warning, works same as todo in android studio
        //            #warning("Dismiss Loading View")
        showLoadingView()
        
        NetworkManager.shared.getFolower(for: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            dismissLoadingView()
            
            switch result {
                case .success(let followers):
                    if followers.count < 100 { self.hasMoreFollowers = false }
                    self.followers.append(contentsOf: followers)
                
                    if self.followers.isEmpty {
                        let message = "This follower doesn't have any followers. Go follow them.."
                        DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                        return
                    }
                    self.updateData(on: self.followers)
                    break
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
                    break
            }
            
        }
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UiHelper.configureThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reUseId)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: FollowerCell.reUseId,
                        for: indexPath
                    ) as! FollowerCell
                cell.set(follower: follower)
                return cell
        })
    }
    
    
    func cofigureSearchController() {
        let searchController                    = UISearchController()
        searchController.searchBar.delegate     = self
        searchController.searchResultsUpdater   = self
        searchController.searchBar.placeholder  = "Search for a username"
        navigationItem.searchController         = searchController
    }
    
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}


extension FollowersListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height, hasMoreFollowers {
            page += 1
            getFollowers(for: userName, at: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower        = isSearching ? filterFollower[indexPath.item] : followers[indexPath.item]
        
        let destVC          = UserInfoVC()
        destVC.userName     = follower.login
        
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        
        isSearching     = true
        filterFollower  = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filterFollower)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching     = false
        filterFollower  = []
        updateData(on: followers)
    }
}
