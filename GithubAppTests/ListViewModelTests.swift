//
//  ListViewModelTests.swift
//  ListViewModelTests
//
//  Created by Andres Mendieta on 21/01/24.
//

import XCTest
import SwiftUI
@testable import GithubApp

final class ListViewModelTests: XCTestCase {

    var sut: ListViewModel!
    var useCase: FetchUsersUseCaseMock!

    override func setUp() {
        super.setUp()
        useCase = FetchUsersUseCaseMock()
        sut = ListViewModel(useCase: useCase)
    }

    override func tearDown() {
        sut = nil
        useCase = nil
        super.tearDown()
    }

    func testFetchUsers_noError_shouldCatchUsers() {
            // Given
        let expectation = self.expectation(description: "Fetch users")
        let expectedUserCount = 6
        useCase.result = .success(GithubStubs.githubUsers)

            // When
        sut.fetchUsers()

            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.users.count, expectedUserCount)
            XCTAssertEqual(self.sut.isLoading, false)
            XCTAssertNil(self.sut.error)
            XCTAssertTrue(self.useCase.calledMethods.contains(.getUsersIn))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)

    }

    func testFetchUsers_onError_shouldCatchError() {
            // Given
        let expectation = self.expectation(description: "Fetch users")
        let expectedError = GithubAPIError.requestFailed
        let expectedUserCount = 0
        useCase.result = .failure(expectedError)

            // When
        sut.fetchUsers()

            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.users.count, expectedUserCount)
            XCTAssertEqual(self.sut.error, expectedError)
            XCTAssertEqual(self.sut.isLoading, false)
            XCTAssertNotNil(self.sut.error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchNewPageOfUsers_shouldCallFetchUsers() {
            // Given
        let expectation = self.expectation(description: "Fetch users")
            // When
        sut.fetchNewPageOfUsers()
            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.useCase.calledMethods.contains(.getUsersIn))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testShouldFetchNewPageIn_whenUserIsLast_shouldCallFetchUsers() {
            // Given
        let expectation = self.expectation(description: "Fetch users")
        sut.users = GithubStubs.users
        let lastUser = sut.users.last!

            // When
        sut.shouldFetchNewPageIn(lastUser)

            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.useCase.calledMethods.contains(.getUsersIn))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testShowErrorView_whenError_ShouldReturnView() {
            // Given
        let error = GithubAPIError.requestFailed
        sut.error = error

            // When
        let errorView = sut.showErrorView() as? ErrorViews

            // Then
        XCTAssertEqual(errorView?.type, error)
    }

    func testGoToDetailsViewFor_ShouldReturnUserDetailsView() {
            // Given
        let user = "nick1"

            // When
        let userView = sut.goToDetailsViewFor(user: user)

            // Then
        XCTAssertTrue(userView is UserDetailsView)
    }

}
