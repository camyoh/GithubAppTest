//
//  ErrorViews.swift
//  GithubApp
//
//  Created by Andres Mendieta on 21/01/24.
//

import SwiftUI

struct ErrorViews: View {
    @State var type: GithubAPIError

    @ViewBuilder
    var body: some View {
        switch type {
            case .invalidURL:
                Text("Invalid Url")
            case .requestFailed:
                Text("Request Failed")
            case .invalidResponse:
                Text("Invalid Response")
            case .decodingError:
                Text("Decoding Error")
            case .noInternet:
                VStack(content: {
                    Image(systemName: "wifi.slash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                    Text("Please check your internet connection")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Text("Tap here to try again")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                })
        }
    }
}
