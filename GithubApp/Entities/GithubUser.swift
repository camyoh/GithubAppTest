//
//  GithubUser.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import Foundation

typealias GithubUsers = [GithubUser]

struct GithubUser: Codable {
    let login: String
    let id: Int
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
