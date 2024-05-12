//
//  NetworkManager.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 03/05/24.
//

import Foundation

class NetworkManager {
    static let shared   = NetworkManager()
    let baseUrl = "https://api.github.com/"
    
    private init() {}
    
    func getFolower( for username: String, page: Int, completed: @escaping(Result<[Follower], GFError>) -> Void) {
        let endPoint = baseUrl + "users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let follower = try decoder.decode([Follower].self, from: data)
                completed(.success(follower))
                
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }
        
        task.resume()
    }
}