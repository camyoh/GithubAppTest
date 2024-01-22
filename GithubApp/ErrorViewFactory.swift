//
//  ErrorViewFactory.swift
//  GithubApp
//
//  Created by Andres Mendieta on 20/01/24.
//

import SwiftUI

struct ErrorViewFactory {
    static func make(for error: GithubAPIError?) -> some View {
        switch error {
            case .decodingError:
                return ErrorViews(type: .decodingError)
            case .invalidResponse:
                return ErrorViews(type: .invalidResponse)
            case .invalidURL:
                return ErrorViews(type: .invalidURL)
            case .noInternet:
                return ErrorViews(type: .noInternet)
            case .requestFailed:
                return ErrorViews(type: .requestFailed)
            default:
                return ErrorViews(type: .requestFailed)
        }
    }
}
