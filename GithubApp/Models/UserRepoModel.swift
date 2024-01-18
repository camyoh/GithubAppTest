//
//  UserRepoModel.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import Foundation

class UserRepoModel {
    let name: String
    let language: String
    let numberStars: Int
    let description: String
    let url: String

    init(
        name: String,
        language: String,
        numberStars: Int,
        description: String,
        url: String
    ) {
        self.name = name
        self.language = language
        self.numberStars = numberStars
        self.description = description
        self.url = url
    }
}
