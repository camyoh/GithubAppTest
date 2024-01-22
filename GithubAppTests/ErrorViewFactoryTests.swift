//
//  ErrorViewFactoryTests.swift
//  GithubAppTests
//
//  Created by Andres Mendieta on 21/01/24.
//

import XCTest
@testable import GithubApp

final class ErrorViewFactoryTests: XCTestCase {

    func testMake_withError_shouldReturnCorrectErrorView() {
            // Given 
        let testCases: [(error: GithubAPIError?, expectedType: GithubAPIError)] = [
            (.decodingError, .decodingError),
            (.invalidResponse, .invalidResponse),
            (.invalidURL, .invalidURL),
            (.noInternet, .noInternet),
            (.requestFailed, .requestFailed),
            (nil, .requestFailed)
        ]

        for testCase in testCases {
                // When
            let view = ErrorViewFactory.make(for: testCase.error) as? ErrorViews

                // Then
            XCTAssertEqual(view?.type, testCase.expectedType)
        }
    }
}
