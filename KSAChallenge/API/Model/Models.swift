//
//  User.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//

struct User: Codable {
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
    let type: String
}

struct Users: Codable, Hashable {
    var login: String
    var avatarUrl: String
}

struct Repositories: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
