//
//  GithubUserDetails.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import Foundation

struct GithubUserDetails: Codable {
    let login: String?
    let id: Int?
    let avatarURL: String?
    let name: String?
    let followers, following: Int?

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case name, followers, following
    }
}
