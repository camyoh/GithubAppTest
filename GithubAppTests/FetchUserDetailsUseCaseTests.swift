//
//  FetchUserDetailsUseCaseTests.swift
//  GithubAppTests
//
//  Created by Andres Mendieta on 21/01/24.
//

import XCTest
@testable import GithubApp

var repository: RepositoryMock!
var sut: FetchUserDetailsUseCase!

final class FetchUserDetailsUseCaseTests: XCTestCase {

    override func setUp() {
        super.setUp()
        repository = RepositoryMock()
        sut = FetchUserDetailsUseCase(repository: repository)
    }

    override func tearDown() {
        sut = nil
        repository = nil
        super.tearDown()
    }

    func testGetUserDetailsFor_whenUserName_shouldReturnDetails() async throws {
            // Given
        let expectedDetails = GithubStubs.details
        repository.detailsResult = .success(expectedDetails)
        let userName = "nick1"

            // When
        let result = try await sut.getUserDetailsFor(userName: userName)

            // Then
        XCTAssertEqual(result.id, expectedDetails.id)
        XCTAssertTrue(repository.calledMethods.contains(.fetchUserDetailsFor))
    }

    func testUserDetailsFor_whenError_shouldThrowError() async throws {
            // Given
        repository.detailsResult = .failure(.requestFailed)
        let userName = "nick1"

        do {
            _ = try await sut.getUserDetailsFor(userName: userName)
            XCTFail("Expected getUsersIn to throw error")
        } catch {
            XCTAssertEqual(error as? GithubAPIError, .requestFailed)
        }
    }

    func testGetUserReposFor_whenUserName_shouldReturnDetails() async throws {
            // Given
        let expectedRepos = GithubStubs.repos
        repository.reposResult = .success(expectedRepos)
        let userName = "nick1"

            // When
        let result = try await sut.getUserReposFor(userName: userName)

            // Then
        XCTAssertEqual(result.first?.id, expectedRepos.first?.id)
        XCTAssertTrue(repository.calledMethods.contains(.fetchUserReposFor))
    }

    func testGetUserReposFor_whenError_shouldThrowError() async throws {
            // Given
        repository.reposResult = .failure(.requestFailed)
        let userName = "nick1"

        do {
            _ = try await sut.getUserReposFor(userName: userName)
            XCTFail("Expected getUsersIn to throw error")
        } catch {
            XCTAssertEqual(error as? GithubAPIError, .requestFailed)
        }
    }
}
