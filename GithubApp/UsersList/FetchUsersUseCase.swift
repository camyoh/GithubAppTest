//
//  FetchUsersUseCase.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import Foundation

class FetchUsersUseCase: FetchUsersUseCaseProtocol {
    private let repository: RepositoryProtocol

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    func getUsersIn(page: Int) async throws -> GithubUsers {
        do {
            let githubUsers = try await repository.fetchAllUsersIn(page: page)
            return githubUsers
        } catch {
            throw error
        }
    }
}
