//
//  ContentView.swift
//  GithubApp
//
//  Created by Andres Mendieta on 15/01/24.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel: ListViewModel

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.error != nil {
                viewModel.showErrorView()
                    .onTapGesture {
                        viewModel.fetchUsers()
                    }
            } else {
                List (viewModel.users) { user in
                    HStack {
                        NavigationLink {
                            viewModel.goToDetailsViewFor(user: user.name)
                        } label: {
                            HStack {
                                AsyncImage(url: URL(string: user.icon)) { phase in
                                    if let image = phase.image {
                                        image.resizable()
                                            .clipShape(Circle())
                                    } else if phase.error != nil {
                                        Image(systemName: "person.fill")
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(width: 40, height: 40)
                                Text(user.name)
                            }
                            .onAppear() {
                                viewModel.shouldFetchNewPageIn(user)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Github Users")
            }
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

    //#Preview {
    //    ListView(viewModel: ListViewModel(useCase: FetchUsersUseCase(repository: Repository())))
    //}
