//
//  GithubAppApp.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import SwiftUI

@main
struct GithubAppApp: App {
    private let repository: RepositoryProtocol
    private let useCase: FetchUsersUseCase
    private let viewModel: ListViewModel

    init() {
        self.repository = Repository()
        self.useCase = FetchUsersUseCase(repository: repository)
        self.viewModel = ListViewModel(useCase: useCase)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ListView(viewModel: viewModel)
            }
        }
    }
}
