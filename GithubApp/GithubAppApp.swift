//
//  GithubAppApp.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import SwiftUI

@main
struct GithubAppApp: App {
    @StateObject private var coordinator = Coordinator()
    private let repository: RepositoryProtocol
    private let useCase: FetchUsersUseCase
    private let viewModel: UsersViewModel

    init() {
        self.repository = Repository()
        self.useCase = FetchUsersUseCase(repository: repository)
        self.viewModel = UsersViewModel(useCase: useCase)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                UsersView(viewModel: viewModel)
                    .environmentObject(coordinator)
            }
        }
    }
}
