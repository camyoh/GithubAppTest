//
//  DataDecoderMock.swift
//  GithubAppTests
//
//  Created by Andres Mendieta on 21/01/24.
//

import Foundation
@testable import GithubApp

class DataDecoderGithubUsersMock: DataDecoderProtocol {
    var decodeResult: Result<GithubUsers, GithubAPIError>!

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        switch decodeResult {
            case .success(let users):
                return users as! T
            case .failure(let error):
                throw error
            case .none:
                throw GithubAPIError.decodingError
        }
    }
}

class DataDecoderGithubDetailsMock: DataDecoderProtocol {
    var decodeResult: Result<GithubUserDetails, GithubAPIError>!

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        switch decodeResult {
            case .success(let users):
                return users as! T
            case .failure(let error):
                throw error
            case .none:
                throw GithubAPIError.decodingError
        }
    }
}

class DataDecoderGithubReposMock: DataDecoderProtocol {
    var decodeResult: Result<GithubUserRepos, GithubAPIError>!

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        switch decodeResult {
            case .success(let users):
                return users as! T
            case .failure(let error):
                throw error
            case .none:
                throw GithubAPIError.decodingError
        }
    }
}
