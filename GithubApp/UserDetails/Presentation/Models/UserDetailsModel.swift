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
    let numberOfFollowers: Int
    let numberOfFollowing: Int

    init(
        iconImage: String = "",
        userName: String = "",
        fullName: String = "",
        numberOfFollowers: Int = 0,
        numberOfFollowing: Int = 0
    ) {
        self.iconImage = iconImage
        self.userName = userName
        self.fullName = fullName
        self.numberOfFollowers = numberOfFollowers
        self.numberOfFollowing = numberOfFollowing
    }
}
