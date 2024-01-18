//
//  UsersViewModel.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published var model = UsersModel()
    private let useCase: FetchUsersUseCaseProtocol
    private var page = 0

    init(
        useCase: FetchUsersUseCaseProtocol
    ) {
        self.useCase = useCase
    }

    func fetchUsers() {
        Task.init {
            do {
                let githubUsers = try await useCase.getUsersIn(page: page)
                let users = mapToUserModel(from: githubUsers)
                await MainActor.run {
                    model.users.append(contentsOf: users)
                }
            } catch {
                print(error)
                //show error view
            }
        }
    }

    func fetchNewPageOfUsers() {
        page = page + 46
        fetchUsers()
    }

    private func mapToUserModel(from githubUsers: GithubUsers) -> [UserModel] {
        githubUsers.map { user in
                .init(id: user.id,
                      icon: user.avatarURL,
                      userName: user.login)
        }
    }
}
