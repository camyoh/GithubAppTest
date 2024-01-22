//
//  FetchUserDetailsUseCaseMock.swift
//  GithubAppTests
//
//  Created by Andres Mendieta on 21/01/24.
//

@testable import GithubApp

class FetchUserDetailsUseCaseMock: FetchUserDetailsUseCaseProtocol {
    struct CalledMethods: OptionSet {
        let rawValue: Int
        static let getUserDetailsFor = CalledMethods(rawValue: 1 << 0)
        static let getUserReposFor = CalledMethods(rawValue: 2 << 0)
    }

    var calledMethods: CalledMethods = []
    var details: Result<GithubApp.GithubUserDetails, GithubAPIError>!
    var repos: Result<GithubApp.GithubUserRepos, GithubAPIError>!

    func getUserDetailsFor(userName: String) async throws -> GithubApp.GithubUserDetails {
        calledMethods.insert(.getUserDetailsFor)
        switch details {
            case .success(let users):
                return users
            case .failure(let error):
                throw error
            case .none:
                throw GithubAPIError.requestFailed
        }
    }

    func getUserReposFor(userName: String) async throws -> GithubApp.GithubUserRepos {
        calledMethods.insert(.getUserReposFor)
        switch repos {
            case .success(let users):
                return users
            case .failure(let error):
                throw error
            case .none:
                throw GithubAPIError.requestFailed
        }
    }
    
    
}
