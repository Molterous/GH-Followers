//
//  PersistanceManager.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 02/07/24.
//

import Foundation


enum PersistanceActionType { case add, remove }


enum PersistanceManager {
    
    
    static private let defaults = UserDefaults.standard
    
    
    enum Keys {
        static let favourites = "favourites"
    }
    
    
    static func updateWith(
        with favourite: Follower,
        for action: PersistanceActionType,
        completed: @escaping(GFError?) -> Void
    ) {
            
            retrieveFavourites { result in
                switch result {
                    case .success(let favourites):
                        var retrievedFollowers = favourites
                        
                        switch action {
                            case .add:
                                guard !retrievedFollowers.contains(favourite) else {
                                    completed(.alreadyInFavourite)
                                    return
                                }
                                
                                retrievedFollowers.append(favourite)
                            
                            case .remove:
                            retrievedFollowers.removeAll { $0.login == favourite.login }
                        }
                    
                        completed(save(favourites: retrievedFollowers))
                    
                    case .failure(let error):
                        completed(error)
                }
            }
            
        }
    
    
    static func retrieveFavourites(completed: @escaping(Result<[Follower], GFError>) -> Void) {
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder     = JSONDecoder()
            let followers   = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(followers))
        } catch {
            completed(.failure(.errorFavouriting))
        }
    }
    
    
    static func save(favourites: [Follower]) -> GFError? {
        
        do {
            let encoder     = JSONEncoder()
            let encodedFavs = try encoder.encode(favourites)
            defaults.setValue(encodedFavs, forKey: Keys.favourites)
            return nil
            
        } catch {
            return .errorFavouriting
        }
    }
}
