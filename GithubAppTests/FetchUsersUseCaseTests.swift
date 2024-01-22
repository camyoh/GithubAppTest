//
//  FetchUsersUseCaseTests.swift
//  GithubAppTests
//
//  Created by Andres Mendieta on 21/01/24.
//

import XCTest
@testable import GithubApp

final class FetchUsersUseCaseTests: XCTestCase {

    var repository: RepositoryMock!
    var sut: FetchUsersUseCase!

    override func setUp() {
        super.setUp()
        repository = RepositoryMock()
        sut = FetchUsersUseCase(repository: repository)
    }

    override func tearDown() {
        sut = nil
        repository = nil
        super.tearDown()
    }

    func testGetUsersIn_whenUsers_shouldReturnUsers() async throws {
            // Given
        let expectedUsers = GithubStubs.githubUsers
        repository.usersResult = .success(expectedUsers)
        let page = 0

            // When
        let result = try await sut.getUsersIn(page: page)

            // Then
        XCTAssertEqual(result.first?.id, expectedUsers.first?.id)
        XCTAssertTrue(repository.calledMethods.contains(.fetchAllUsersIn))
    }

    func testGetUsersIn_whenError_shouldThrowError() async throws {
            // Given
        repository.usersResult = .failure(.requestFailed)
        let page = 0

        do {
            _ = try await sut.getUsersIn(page: page)
            XCTFail("Expected getUsersIn to throw error")
        } catch {
            XCTAssertEqual(error as? GithubAPIError, .requestFailed)
        }
    }

}
