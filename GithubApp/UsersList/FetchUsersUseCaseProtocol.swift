//
//  FetchUsersUseCaseProtocol.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import Foundation

protocol FetchUsersUseCaseProtocol {
    func getUsersIn(page: Int) async throws -> GithubUsers
}
