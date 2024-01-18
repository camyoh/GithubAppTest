//
//  UserModel.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import Foundation

struct UserModel: Equatable, Identifiable {
    let id: Int
    let icon: String
    let userName: String

    init(
        id: Int,
        icon: String,
        userName: String
    ) {
        self.id = id
        self.icon = icon
        self.userName = userName
    }
}

extension UserModel: CustomStringConvertible {
    var description: String {
        "\n{icon: \(icon), user: \(userName)}"
    }
}