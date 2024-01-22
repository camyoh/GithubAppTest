//
//  RepositoryTests.swift
//  GithubAppTests
//
//  Created by Andres Mendieta on 21/01/24.
//

import XCTest
@testable import GithubApp

final class RepositoryTests: XCTestCase {

    var apiClientMock: ApiClientMock!
    var dataDecoderMock: DataDecoderProtocol!
    var sut: Repository!

    override func setUp() {
        super.setUp()
        apiClientMock = ApiClientMock()
    }

    override func tearDown() {
        apiClientMock = nil
        dataDecoderMock = nil
        sut = nil
        super.tearDown()
    }

    func testFetchAllUsersIn() async throws {
            // Given
        let dataDecoderMock = DataDecoderGithubUsersMock()
        let sut = Repository(apiClient: apiClientMock, dataDecoder: dataDecoderMock)
        let expectedUsers = GithubStubs.githubUsers
        let expectedId = expectedUsers.first?.id
        apiClientMock.dataResult = .success(Data())
        dataDecoderMock.decodeResult = .success(expectedUsers)
        let page = 1

            // When
        let result = try await sut.fetchAllUsersIn(page: page)

            // Then
        XCTAssertEqual(result.first?.id, expectedId)
    }

    func testFetchAllUsersIn_whenNoInternet_shouldCatchError() async throws {
            // Given
        let dataDecoderMock = DataDecoderGithubUsersMock()
        let sut = Repository(apiClient: apiClientMock, dataDecoder: dataDecoderMock)
        dataDecoderMock.decodeResult = .failure(.noInternet)
        let page = 1
        
            // When & Then
        do {
            _ = try await sut.fetchAllUsersIn(page: page)
            XCTFail("Expected fetchAllUsersIn to throw noInternet error")
        } catch {
            XCTAssertEqual(error as? GithubAPIError, .noInternet)
        }
    }

    func testFetchAllUsersIn_whenCantDecode_shouldCatchError() async throws {
            // Given
        let dataDecoderMock = DataDecoderGithubUsersMock()
        let sut = Repository(apiClient: apiClientMock, dataDecoder: dataDecoderMock)
        apiClientMock.dataResult = .failure(GithubAPIError.decodingError)
        dataDecoderMock.decodeResult = .failure(.decodingError)
        let page = 1

            // When & Then
        do {
            _ = try await sut.fetchAllUsersIn(page: page)
            XCTFail("Expected fetchAllUsersIn to throw decoding error")
        } catch {
            XCTAssertEqual(error as? GithubAPIError, .decodingError)
        }
    }

    func testFetchUserDetailsFor() async throws {
            // Given
        let dataDecoderMock = DataDecoderGithubDetailsMock()
        let sut = Repository(apiClient: apiClientMock, dataDecoder: dataDecoderMock)
        let expectedDetails = GithubStubs.details
        let expectedId = expectedDetails.id
        apiClientMock.dataResult = .success(Data())
        dataDecoderMock.decodeResult = .success(expectedDetails)

            // When
        let result = try await sut.fetchUserDetailsFor(userName: "nick1")

            // Then
        XCTAssertEqual(result.id, expectedId)
    }

    func testFetchUserDetailsFor_whenCantDecode_catchError() async throws {
            // Given
        let dataDecoderMock = DataDecoderGithubDetailsMock()
        let sut = Repository(apiClient: apiClientMock, dataDecoder: dataDecoderMock)
        apiClientMock.dataResult = .failure(GithubAPIError.decodingError)
        dataDecoderMock.decodeResult = .failure(.decodingError)

            // When & Then
        do {
            _ = try await sut.fetchUserDetailsFor(userName: "nick1")
            XCTFail("Expected fetchAllUsersIn to throw decoding error")
        } catch {
            XCTAssertEqual(error as? GithubAPIError, .decodingError)
        }
    }

    func testFetchUserReposFor() async throws {
            // Given
        let dataDecoderMock = DataDecoderGithubReposMock()
        let sut = Repository(apiClient: apiClientMock, dataDecoder: dataDecoderMock)
        let expectedDetails = GithubStubs.repos
        let expectedId = expectedDetails.first?.id
        apiClientMock.dataResult = .success(Data())
        dataDecoderMock.decodeResult = .success(expectedDetails)

            // When
        let result = try await sut.fetchUserReposFor(userName: "nick1")

            // Then
        XCTAssertEqual(result.first?.id, expectedId)
    }

    func testFetchUserReposFor_whenCantDecode_catchError() async throws {
            // Given
        let dataDecoderMock = DataDecoderGithubReposMock()
        let sut = Repository(apiClient: apiClientMock, dataDecoder: dataDecoderMock)
        apiClientMock.dataResult = .failure(GithubAPIError.decodingError)
        dataDecoderMock.decodeResult = .failure(.decodingError)

            // When & Then
        do {
            _ = try await sut.fetchUserReposFor(userName: "nick1")
            XCTFail("Expected fetchAllUsersIn to throw decoding error")
        } catch {
            XCTAssertEqual(error as? GithubAPIError, .decodingError)
        }
    }

}
