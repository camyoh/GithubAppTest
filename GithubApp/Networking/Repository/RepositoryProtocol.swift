//
//  RepositoryProtocol.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import Foundation

protocol RepositoryProtocol {
    func fetchAllUsersIn(page: Int) async throws -> GithubUsers
    func fetchUserDetailsFor(userName: String) async throws -> GithubUserDetails
    func fetchUserReposFor(userName: String) async throws -> GithubUserRepos
}
