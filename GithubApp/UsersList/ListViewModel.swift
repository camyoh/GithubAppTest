//
//  ListViewModel.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import SwiftUI

class ListViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    @Published var isLoading = false
    @Published var error: GithubAPIError? = nil
    private let useCase: FetchUsersUseCaseProtocol
    private var page = 0

    init(
        useCase: FetchUsersUseCaseProtocol
    ) {
        self.useCase = useCase
    }

    func onAppear() {
        if users.isEmpty {
            fetchUsers()
        }
    }

    func fetchUsers() {
        isLoading = (page == 0)
        error = nil
        Task.init {
            do {
                let githubUsers = try await useCase.getUsersIn(page: page)
                let users = mapToUserModel(from: githubUsers)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.users.append(contentsOf: users)
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.error = error as? GithubAPIError
                }
            }
        }
    }

    func fetchNewPageOfUsers() {
        page = page + 46
        fetchUsers()
    }

    func shouldFetchNewPageIn(_ user: UserModel) {
        if let lastUser = users.last, lastUser == user {
            fetchNewPageOfUsers()
        }
    }

    func goToDetailsViewFor(user: String) -> some View {
        let viewModel = UserDetailsViewModel(
            userName: user,
            useCase: FetchUserDetailsUseCase(repository: Repository())
        )

        return UserDetailsView(viewModel: viewModel)
    }

    func showErrorView() -> some View {
        ErrorViewFactory.make(for: error)
    }

    private func mapToUserModel(from githubUsers: GithubUsers) -> [UserModel] {
        githubUsers.map { user in
                .init(id: user.id,
                      icon: user.avatarURL,
                      userName: user.login.capitalized)
        }
    }
}
