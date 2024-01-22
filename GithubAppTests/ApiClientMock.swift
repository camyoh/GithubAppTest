//
//  ApiClientMock.swift
//  GithubAppTests
//
//  Created by Andres Mendieta on 21/01/24.
//

import Foundation
@testable import GithubApp

class ApiClientMock: ApiClientProtocol {
    var dataResult: Result<Data, Error>!

    func fetchData(from url: URL) async throws -> Data {
        switch dataResult {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
            case .none:
                throw URLError(.badServerResponse)
        }
    }
}
