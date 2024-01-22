//
//  FetchUserDetailsUseCaseProtocol.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import Foundation

protocol FetchUserDetailsUseCaseProtocol {
    func getUserDetailsFor(userName: String) async throws -> GithubUserDetails
    func getUserReposFor(userName: String) async throws -> GithubUserRepos
}
