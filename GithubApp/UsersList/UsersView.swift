//
//  ContentView.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import SwiftUI

struct UsersView: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: UsersViewModel

    var body: some View {
        NavigationStack {
            List (viewModel.model.users) { user in
                HStack {
                    NavigationLink {
                        viewModel.goToDetailsViewFor(user: user.userName)
                            .navigationTitle(user.userName)
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: user.icon)) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                } else if phase.error != nil {
                                    Image(systemName: "person.fill")
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(width: 40, height: 40)
                            Text(user.userName)
                        }
                        .onAppear() {
                            if (self.viewModel.model.users.last == user) {
                                viewModel.fetchNewPageOfUsers()
                            }
                        }
                    }
                }

            }
            .navigationTitle("Github Users")
            .listStyle(.plain)
        }
        .onAppear(perform: {
            viewModel.fetchUsers()
        })
    }
}

    //#Preview {
    //    UsersView(viewModel: UsersViewModel(useCase: FetchUsersUseCase(repository: Repository())))
    //}
