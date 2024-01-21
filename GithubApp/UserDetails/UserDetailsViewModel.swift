//
//  UserDetailsViewModel.swift
//  GithubApp
//
//  Created by Andres Mendieta on 18/01/24.
//

import SwiftUI

class UserDetailsViewModel: ObservableObject {
    @Published var model = UserDetailsModel()
    @Published var repoModels = [UserRepoModel]()
    @Published var isLoading = false
    @Published var isLoadingRepos = false
    @Published var error: GithubAPIError? = nil
    @Published var errorInRepos: GithubAPIError? = nil

    var selectedRepo = UserRepoModel()
    var userName: String
    private var useCase: FetchUserDetailsUseCaseProtocol

    init(
        userName: String,
        useCase: FetchUserDetailsUseCaseProtocol
    ) {
        self.userName = userName
        self.useCase = useCase
    }

    func fetchUserDetails() {
        isLoading = true
        error = nil
        Task.init {
            do {
                let githubUserDetails = try await useCase.getUserDetailsFor(userName: userName)
                let userDetails = mapToUserDetails(from: githubUserDetails)
                await MainActor.run {
                    model = userDetails
                    isLoading = false
                }
            } catch {
                isLoading = false
                self.error = error as? GithubAPIError
            }
        }
    }

    func fetchUserRepos() {
        isLoadingRepos = true
        errorInRepos = nil
        Task.init {
            do {
                let githubUserRepos = try await useCase.getUserReposFor(userName: userName)
                let userRepos = mapToRepoModels(from: githubUserRepos)
                await MainActor.run {
                    repoModels = userRepos
                    isLoadingRepos = false
                }
            } catch {
                isLoadingRepos = false
                self.errorInRepos = error as? GithubAPIError
            }
        }
    }

    func showErrorView() -> some View {
        ErrorViewFactory.make(for: error)
    }

    private func mapToRepoModels(from repos: GithubUserRepos) -> [UserRepoModel] {
        repos.map { repo in
                .init(id: repo.id ?? 0,
                      name: repo.name ?? "",
                      language: repo.language ?? "",
                      numberStars: repo.stargazersCount ?? 0,
                      description: repo.description ?? "",
                      url: URL(string: repo.htmlURL ?? ""))
        }
    }

    private func mapToUserDetails(from githubUserDetails: GithubUserDetails) -> UserDetailsModel {
        .init(iconImage: githubUserDetails.avatarURL,
              userName: githubUserDetails.login,
              fullName: githubUserDetails.name.capitalized,
              numberOfFollowers: githubUserDetails.followers,
              numberOfFollowing: githubUserDetails.following)
    }
}
