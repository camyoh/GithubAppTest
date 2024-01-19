//
//  UserDetailsViewModel.swift
//  GithubApp
//
//  Created by Andres Mendieta on 18/01/24.
//

import Foundation

class UserDetailsViewModel: ObservableObject {
    @Published var model = UserDetailsModel()
    @Published var repoModels = [UserRepoModel]()
    var selectedRepo = UserRepoModel()
    private var userName: String
    private var useCase: FetchUserDetailsUseCaseProtocol

    init(
        userName: String,
        useCase: FetchUserDetailsUseCaseProtocol
    ) {
        self.userName = userName
        self.useCase = useCase
    }

    func fetchUserDetails() {
        Task.init {
            do {
                let githubUserDetails = try await useCase.getUserDetailsFor(userName: userName)
                let userDetails = mapToUserDetails(from: githubUserDetails)
                await MainActor.run {
                    model = userDetails
                }
            } catch {
                print(error)
            }
        }
    }

    func fetchUserRepos() {
        Task.init {
            do {
                let githubUserRepos = try await useCase.getUserReposFor(userName: userName)
                let userRepos = mapToRepoModels(from: githubUserRepos)
                await MainActor.run {
                    repoModels = userRepos
                }
            } catch {
                print(error)
            }
        }
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
