//
//  FetchUsersUseCase.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import Foundation

class FetchUsersUseCase: FetchUsersUseCaseProtocol {
    private let repository: RepositoryProtocol
    var isLoadingUsers: Bool = false

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    func getUsersIn(page: Int) async throws -> GithubUsers {
        isLoadingUsers = true
        do {
            let githubUsers = try await repository.fetchAllUsersIn(page: page)
            return githubUsers
        } catch {
            print("Error: \(error)")
            throw error
        }
    }
    

}
