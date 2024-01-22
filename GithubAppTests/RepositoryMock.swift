//
//  RepositoryMock.swift
//  GithubAppTests
//
//  Created by Andres Mendieta on 21/01/24.
//

@testable import GithubApp

class RepositoryMock: RepositoryProtocol {
    struct CalledMethods: OptionSet {
        let rawValue: Int
        static let fetchAllUsersIn = CalledMethods(rawValue: 1 << 0)
        static let fetchUserDetailsFor = CalledMethods(rawValue: 2 << 0)
        static let fetchUserReposFor = CalledMethods(rawValue: 3 << 0)
    }

    var calledMethods: CalledMethods = []
    var usersResult: Result<GithubApp.GithubUsers, GithubAPIError>!
    var detailsResult: Result<GithubApp.GithubUserDetails, GithubAPIError>!
    var reposResult: Result<GithubApp.GithubUserRepos, GithubAPIError>!

    func fetchAllUsersIn(page: Int) async throws -> GithubApp.GithubUsers {
        calledMethods.insert(.fetchAllUsersIn)
        switch usersResult {
            case .success(let users):
                return users
            case .failure(let error):
                throw error
            case .none:
                throw GithubAPIError.requestFailed
        }
    }
    
    func fetchUserDetailsFor(userName: String) async throws -> GithubApp.GithubUserDetails {
        calledMethods.insert(.fetchUserDetailsFor)
        switch detailsResult {
            case .success(let details):
                return details
            case .failure(let error):
                throw error
            case .none:
                throw GithubAPIError.requestFailed
        }
    }
    
    func fetchUserReposFor(userName: String) async throws -> GithubApp.GithubUserRepos {
        calledMethods.insert(.fetchUserReposFor)
        switch reposResult {
            case .success(let repos):
                return repos
            case .failure(let error):
                throw error
            case .none:
                throw GithubAPIError.requestFailed
        }
    }
    

}

