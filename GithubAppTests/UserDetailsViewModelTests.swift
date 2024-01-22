//
//  UserDetailsViewModelTests.swift
//  GithubAppTests
//
//  Created by Andres Mendieta on 21/01/24.
//

import XCTest
@testable import GithubApp

final class UserDetailsViewModelTests: XCTestCase {

    var sut: UserDetailsViewModel!
    var useCase: FetchUserDetailsUseCaseMock!

    override func setUp() {
        super.setUp()
        useCase = FetchUserDetailsUseCaseMock()
        sut = UserDetailsViewModel(userName: "Nick1", useCase: useCase)
    }

    override func tearDown() {
        sut = nil
        useCase = nil
        super.tearDown()
    }

    func testFetchUserDetails() {
            // Given
        let expectation = self.expectation(description: "Fetch user details")
        let expectedName = "nick1"
        useCase.details = .success(GithubStubs.details)

            // When
        sut.fetchUserDetails()

            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.model.userName, expectedName)
            XCTAssertEqual(self.sut.isLoading, false)
            XCTAssertNil(self.sut.error)
            XCTAssertTrue(self.useCase.calledMethods.contains(.getUserDetailsFor))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchUserDetails_withError_shouldCatchError() {
            // Given
        let expectation = self.expectation(description: "Fetch user details")
        let expectedError = GithubAPIError.requestFailed
        useCase.details = .failure(expectedError)

            // When
        sut.fetchUserDetails()

            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.isLoading, false)
            XCTAssertNotNil(self.sut.error)
            XCTAssertEqual(self.sut.error, expectedError)
            XCTAssertTrue(self.useCase.calledMethods.contains(.getUserDetailsFor))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testfetchUserRepos() {
            // Given
        let expectation = self.expectation(description: "Fetch user repos")
        let expectedRepoName = "Nick1"
        useCase.repos = .success(GithubStubs.repos)

            // When
        sut.fetchUserRepos()

            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.repoModels.first?.name, expectedRepoName)
            XCTAssertEqual(self.sut.isLoadingRepos, false)
            XCTAssertNil(self.sut.error)
            XCTAssertTrue(self.useCase.calledMethods.contains(.getUserReposFor))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testfetchUserRepos_noRepos_shouldReturnDefaultValues() {
            // Given
        let expectation = self.expectation(description: "Fetch user repos")
        useCase.repos = .success(GithubStubs.reposNilValues)

            // When
        sut.fetchUserRepos()

            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.repoModels.first?.name, "")
            XCTAssertEqual(self.sut.repoModels.first?.id, 0)
            XCTAssertEqual(self.sut.repoModels.first?.language, "")
            XCTAssertEqual(self.sut.isLoadingRepos, false)
            XCTAssertNil(self.sut.error)
            XCTAssertTrue(self.useCase.calledMethods.contains(.getUserReposFor))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testfetchUserRepos_withError_shouldCatchError() {
            // Given
        let expectation = self.expectation(description: "Fetch user repos")
        let expectedError = GithubAPIError.requestFailed
        useCase.repos = .failure(expectedError)

            // When
        sut.fetchUserRepos()

            // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.sut.repoModels.isEmpty)
            XCTAssertEqual(self.sut.isLoadingRepos, false)
            XCTAssertNotNil(self.sut.errorInRepos)
            XCTAssertTrue(self.useCase.calledMethods.contains(.getUserReposFor))
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

}
