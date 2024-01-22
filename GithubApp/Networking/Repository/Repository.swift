//
//  Repository.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import Foundation

class Repository: RepositoryProtocol {

    private let apiClient: ApiClientProtocol
    private let dataDecoder: DataDecoderProtocol

    init(
        apiClient: ApiClientProtocol = URLSessionAPIClient(),
        dataDecoder: DataDecoderProtocol = JSONDecoderWrapper()
    ) {
        self.apiClient = apiClient
        self.dataDecoder = dataDecoder
    }

    func fetchAllUsersIn(page: Int) async throws -> GithubUsers {
        guard let apiUrl = URL(string: "https://api.github.com/users?since=\(page)") else {
            throw GithubAPIError.invalidURL
        }

        do {
            let data = try await apiClient.fetchData(from: apiUrl)
            let users = try dataDecoder.decode(GithubUsers.self, from: data)
            return users
        } catch {
            throw error
        }
    }

    func fetchUserDetailsFor(userName: String) async throws -> GithubUserDetails {
        guard let apiUrl = URL(string: "https://api.github.com/users/\(userName)") else {
            throw GithubAPIError.invalidURL
        }

        do {
            let data = try await apiClient.fetchData(from: apiUrl)
            let userDetails = try dataDecoder.decode(GithubUserDetails.self, from: data)
            return userDetails
        } catch {
            throw GithubAPIError.decodingError
        }
    }

    func fetchUserReposFor(userName: String) async throws -> GithubUserRepos {
        guard let apiUrl = URL(string: "https://api.github.com/users/\(userName)/repos") else {
            throw GithubAPIError.invalidURL
        }

        do {
            let data = try await apiClient.fetchData(from: apiUrl)
            let userRepos = try dataDecoder.decode(GithubUserRepos.self, from: data)
            return userRepos
        } catch {
            throw GithubAPIError.decodingError
        }
    }
}

enum GithubAPIError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
    case noInternet
}
