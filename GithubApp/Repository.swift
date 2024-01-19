//
//  Repository.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import Foundation

class Repository: RepositoryProtocol {
    func fetchAllUsersIn(page: Int = 0) async throws -> GithubUsers {
        guard let apiUrl = URL(string: "https://api.github.com/users?since=\(page)") else {
            throw GithubAPIError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: apiUrl)

            let decoder = JSONDecoder()
            let users = try decoder.decode(GithubUsers.self, from: data)

            return users
        } catch {
            throw GithubAPIError.requestFailed
        }
    }
    
    func fetchUserDetailsFor(userName: String) async throws -> GithubUserDetails {
        guard let apiUrl = URL(string: "https://api.github.com/users/\(userName)") else {
            throw GithubAPIError.invalidURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: apiUrl)

            let decoder = JSONDecoder()
            let userDescription = try decoder.decode(GithubUserDetails.self, from: data)

            return userDescription
        } catch {
            throw GithubAPIError.requestFailed
        }
    }

    func fetchUserReposFor(userName: String) async throws -> GithubUserRepos {
        guard let apiUrl = URL(string: "https://api.github.com/users/\(userName)/repos") else {
            throw GithubAPIError.invalidURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: apiUrl)
            let decoder = JSONDecoder()
            let userRepos = try decoder.decode(GithubUserRepos.self, from: data)

            return userRepos
        } catch {
            throw GithubAPIError.requestFailed
        }

    }


}

enum GithubAPIError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
}
