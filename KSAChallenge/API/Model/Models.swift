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
    let htmlUrl: String?
    let following: Int
    let followers: Int
    let createdAt: String?
    let type: String?
}

struct Users: Codable {
    var login: String
    var avatarUrl: String
}

struct Repositories: Codable {
    let id: Int?
    let name: String
    let full_name: String?
    let description: String?
    let license: License?
    let fork: Bool?
    let forks: Int
    let forks_count: Int?
    let url: String?
    let owner: Users
}

struct License: Codable {
    var node_id: String?
    var key: String?
    var spdx_id: String?
    var name: String
    var url: String?
}


struct ForksUsers: Codable {
    let id: Int?
    let name: String
    let full_name: String?
    let description: String?
    let license: License?
    let fork: Bool?
    let forks: Int
    let forks_count: Int?
    let url: String?
    let owner: Users
}
