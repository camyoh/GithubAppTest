//
//  UserModel.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import Foundation

struct UsersModel {
    var users: [UserModel]

    init(users: [UserModel] = []) {
        self.users = users
    }
}
