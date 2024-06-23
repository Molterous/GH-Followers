//
//  User.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 03/05/24.
//

import Foundation

class User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
