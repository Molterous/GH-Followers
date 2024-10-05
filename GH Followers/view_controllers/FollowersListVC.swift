//
//  FollowersListVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 18/04/24.
//

import UIKit


protocol FollowersListVCDelegate: AnyObject {
    func didRequestFollowers(for userName: String)
}


class FollowersListVC: UIViewController {

    enum Section { case main }
    
    
    var userName: String!
    var page                = 1
    var hasMoreFollowers    = true
    var isSearching         = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers:      [Follower]  = []
    var filterFollower: [Follower]  = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addToFavourites)
        )
        
        configureVC()
        cofigureSearchController()
        configureCollectionView()
        getFollowers(for: userName, at: page)
        configureDataSource()
    }
    
    
    @objc func addToFavourites() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
                case .success(let user):
                    let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                    
                    PersistanceManager.updateWith(with: favourite, for: .add) { [weak self] error in
                        guard let self = self else { return }
                        
                        guard let error = error else {
                            
                            self.presentGFAlertOnMainThread(
                                title: "Success!!",
                                message: "You have successfully favourited this user.",
                                buttonTitle: "Hooray"
                            )
                            return
                        }
                        
                        self.presentGFAlertOnMainThread(
                            title: "Something went wrong",
                            message: error.rawValue,
                            buttonTitle: "OK"
                        )
                    }
                
                case .failure(let error):
                    self.presentGFAlertOnMainThread(
                        title: "Something went wrong",
                        message: error.rawValue,
                        buttonTitle: "OK"
                    )
            }
        }
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
        
        NetworkManager.shared.getFollower(for: userName, page: page) { [weak self] result in
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
        
        let destVC                      = UserInfoVC()
        destVC.userName                 = follower.login
        destVC.followerListVcDelegate   = self
        
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


extension FollowersListVC: FollowersListVCDelegate {
    
    func didRequestFollowers(for userName: String) {
        self.userName   = userName
        self.title      = userName
        self.page       = 1
        
        self.followers.removeAll()
        self.filterFollower.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        
        getFollowers(for: userName, at: page)
    }
    
}
