//
//  UserRepoModel.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import Foundation

class UserRepoModel: Identifiable {
    let id: Int
    let name: String
    let language: String
    let numberStars: Int
    let description: String
    let url: URL?

    init(
        id: Int = 0,
        name: String = "",
        language: String = "",
        numberStars: Int = 0,
        description: String = "",
        url: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.language = language
        self.numberStars = numberStars
        self.description = description
        self.url = url
    }
}
