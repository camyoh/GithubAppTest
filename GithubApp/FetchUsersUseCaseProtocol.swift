//
//  FetchUsersUseCaseProtocol.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import Foundation

protocol FetchUsersUseCaseProtocol {
    var isLoadingUsers: Bool { get set }
    func getUsersIn(page: Int) async throws -> GithubUsers
}
