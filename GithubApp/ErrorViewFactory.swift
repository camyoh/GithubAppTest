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
                return AnyView(
                    Text("Decoding Error")
                )
            case .invalidResponse:
                return AnyView(
                    Text("Invalid Response")
                )
            case .invalidURL:
                return AnyView(
                    Text("Invalid Url")
                )
            case .noInternet:
                return AnyView(
                    VStack(content: {
                        Image(systemName: "wifi.slash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        Text("Please check your internet connection")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                        Text("Tap here to try again")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                    })
                )
            case .requestFailed:
                return AnyView(
                    Text("Request Failed")
                )
            default:
                return AnyView(
                    Text("Ups we have some problems...")
                )
        }
    }
}
