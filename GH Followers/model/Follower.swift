//
//  Follower.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 03/05/24.
//

import Foundation

class Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    static func == (lhs: Follower, rhs: Follower) -> Bool {
        return lhs.login == rhs.login
    }

    
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}
