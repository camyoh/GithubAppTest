//
//  UserDetailsModel.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import Foundation

struct UserDetailsModel {
    let iconImage: String
    let userName: String
    let fullName: String
    let numberOfFollowers: String

    init(
        iconImage: String,
        userName: String,
        fullName: String,
        numberOfFollowers: String
    ) {
        self.iconImage = iconImage
        self.userName = userName
        self.fullName = fullName
        self.numberOfFollowers = numberOfFollowers
    }
}
