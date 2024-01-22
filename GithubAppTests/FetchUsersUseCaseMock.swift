//
//  FetchUsersUseCaseMock.swift
//  GithubAppTests
//
//  Created by Andres Mendieta on 21/01/24.
//

@testable import GithubApp

class FetchUsersUseCaseMock: FetchUsersUseCaseProtocol {
    struct CalledMethods: OptionSet {
        let rawValue: Int
        static let getUsersIn = CalledMethods(rawValue: 1 << 0)
    }

    var calledMethods: CalledMethods = []
    var result: Result<GithubApp.GithubUsers, GithubAPIError>!

    func getUsersIn(page: Int) async throws -> GithubApp.GithubUsers {
        calledMethods.insert(.getUsersIn)
        switch result {
            case .success(let users):
                return users
            case .failure(let error):
                throw error
            case .none:
                throw GithubAPIError.requestFailed
        }
    }
}
