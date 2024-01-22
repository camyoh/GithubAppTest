//
//  ApiClientProtocol.swift
//  GithubApp
//
//  Created by Andres Mendieta on 21/01/24.
//

import Foundation

protocol ApiClientProtocol {
    func fetchData(from url: URL) async throws -> Data
}

class URLSessionAPIClient: ApiClientProtocol {
    func fetchData(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            if error is URLError {
                throw GithubAPIError.noInternet
            }
            throw GithubAPIError.requestFailed
        }
    }
}
