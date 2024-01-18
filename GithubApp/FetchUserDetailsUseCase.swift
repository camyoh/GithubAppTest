//
//  FetchUserDetailsUseCase.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import Foundation

class FetchUserDetailsUseCase: FetchUserDetailsUseCaseProtocol {
    var repository: RepositoryProtocol
    var isLoadingUserDetails: Bool = false
    var isLoadingRepos: Bool = false

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    func getUserDetailsFor(userName: String) async throws -> GithubUserDetails {
        isLoadingUserDetails = true

        do {
            let githubUserDetails = try await repository.fetchUserDetailsFor(userName: userName)
            return githubUserDetails
        } catch {
            throw error
        }
    }

    func getUserReposFor(userName: String) async throws -> GithubUserRepos {
        isLoadingRepos = true

        do {
            let userRepos = try await repository.fetchUserReposFor(userName: userName)
            print(userRepos)
            return userRepos
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
}
