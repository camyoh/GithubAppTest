//
//  GithubUserRepo.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import Foundation

typealias GithubUserRepos = [GithubUserRepo]

struct GithubUserRepo: Codable {
    let id: Int?
    let name: String?
    let htmlURL: String?
    let description: String?
    let stargazersCount: Int?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case htmlURL = "html_url"
        case description
        case stargazersCount = "stargazers_count"
        case language
    }
}
