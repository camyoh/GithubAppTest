//
//  FetchUserDetailsUseCase.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import Foundation

class FetchUserDetailsUseCase: FetchUserDetailsUseCaseProtocol {
    var repository: RepositoryProtocol

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    func getUserDetailsFor(userName: String) async throws -> GithubUserDetails {
        do {
            let githubUserDetails = try await repository.fetchUserDetailsFor(userName: userName)
            return githubUserDetails
        } catch {
            throw error
        }
    }

    func getUserReposFor(userName: String) async throws -> GithubUserRepos {
        do {
            let userRepos = try await repository.fetchUserReposFor(userName: userName)
            return userRepos
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
}
