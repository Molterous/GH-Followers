//
//  FavoritesVC.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 03/04/24.
//

import UIKit

class FavoritesVC: UIViewController {

    let tableView               =  UITableView()
    var favourites: [Follower]  =  []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavs()
    }
    
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func configureTableView() {
        
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(FavouritesCell.self, forCellReuseIdentifier: FavouritesCell.reUseId)
    }
    
    
    private func getFavs() {
        
        showLoadingView()
        
        PersistanceManager.retrieveFavourites() { [weak self] result in
            
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
                case .success(let favourites):
                    if favourites.isEmpty {
                        self.showEmptyStateView(with: "No Favourites?\nAdd one on the follower screen.", in: self.view)
                    } else {
                        self.favourites = favourites
                        DispatchQueue.main.async { self.tableView.reloadData() }
                        self.view.bringSubviewToFront(self.tableView)
                    }
                    break
                
                case .failure(let error):
                    self.presentGFAlertOnMainThread(
                        title: "Something went wrong",
                        message: error.rawValue,
                        buttonTitle: "OK"
                    )
                    break
            }
        }
    }

}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favourites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesCell.reUseId) as! FavouritesCell
        let favorite = self.favourites[indexPath.row]
        
        cell.set(fav: favorite)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite    = self.favourites[indexPath.row]
        
        let destVC      = FollowersListVC()
        destVC.userName = favorite.login
        destVC.title    = favorite.login
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle  == .delete else { return }
        let favorite        = self.favourites[indexPath.row]
        
        PersistanceManager.updateWith(with: favorite, for: .remove) { [weak self] error in
            
            guard let self  = self else { return }
            guard let error = error else {
                self.favourites.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
                
                self.showEmptyStateView(with: "No Favvurites?\nAdd one on the follower screen.", in: self.view)
                
                return
            }
            
            self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "OK")
        }
        
    }
}
