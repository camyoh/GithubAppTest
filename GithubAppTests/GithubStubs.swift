//
//  GithubStubs.swift
//  GithubAppTests
//
//  Created by Andres Mendieta on 21/01/24.
//

import Foundation
@testable import GithubApp

struct GithubStubs {
    static var githubUsers: [GithubUser] = [
        .init(login: "nick1", id: 1, avatarURL: "www.avatar.com"),
        .init(login: "nick2", id: 2, avatarURL: "www.avatar.com"),
        .init(login: "nick3", id: 3, avatarURL: "www.avatar.com"),
        .init(login: "nick4", id: 4, avatarURL: "www.avatar.com"),
        .init(login: "nick5", id: 5, avatarURL: "www.avatar.com"),
        .init(login: "nick6", id: 6, avatarURL: "www.avatar.com")
    ]

    static var users: [UserModel] = [
        .init(id: 1, icon: "icon1", userName: "nick1"),
        .init(id: 2, icon: "icon2", userName: "nick2"),
        .init(id: 3, icon: "icon3", userName: "nick3"),
        .init(id: 4, icon: "icon4", userName: "nick4"),
        .init(id: 5, icon: "icon5", userName: "nick5"),
        .init(id: 6, icon: "icon6", userName: "nick6")
    ]

    static var details: GithubUserDetails = .init(
        login: "nick1",
        id: 1,
        avatarURL: "www.avatar.com",
        name: "Nick F",
        followers: 1,
        following: 1
    )

    static var repos: GithubUserRepos = [
        .init(id: 1,
              name: "Nick1",
              htmlURL: "www.github.com",
              description: "description",
              stargazersCount: 1,
              language: "Swift")
    ]

    static var reposNilValues: GithubUserRepos = [
        .init(
            id: nil,
            name: nil,
            htmlURL: nil,
            description: nil,
            stargazersCount: nil,
            language: nil)
    ]
}
