//
//  UserDetailsView.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import SwiftUI

struct UserDetailsView: View {
    @ObservedObject var viewModel: UserDetailsViewModel
    @State private var showWebView = false

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.error != nil {
                viewModel.showErrorView()
            } else {
                AsyncImage(url: URL(string: viewModel.model.iconImage)) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .clipShape(Circle())
                    } else if phase.error != nil {
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 80, height: 80)
                Text(viewModel.model.fullName)
                    .font(.title)
                    .padding(.bottom, 5)
                HStack(spacing: 20) {
                    VStack(content: {
                        Text("Followers")
                            .font(.headline)
                        Text("\(viewModel.model.numberOfFollowers)")
                    })
                    VStack(content: {
                        Text("Following")
                            .font(.headline)
                        Text("\(viewModel.model.numberOfFollowing)")
                    })
                }
                Divider()
            }
            if viewModel.isLoadingRepos {
                if viewModel.isLoading {
                    EmptyView()
                } else {
                    ProgressView()
                }
            } else if viewModel.errorInRepos != nil {
                viewModel.showErrorView()
            } else {
                VStack {
                    Text("Repositories")
                        .font(.title3)
                        .fontWeight(.bold)
                    List(viewModel.repoModels) { repo in
                        Button(action: {
                            viewModel.selectedRepo = repo
                            showWebView = true
                        }, label: {
                            VStack(alignment: .leading) {
                                Text("Title: \(repo.name)")
                                Text("Language: \(repo.language)")
                                Text("Stars: \(repo.numberStars)")
                                if !repo.description.isEmpty {
                                    Text(repo.description)
                                }
                            }
                        })
                    }
                    .sheet(isPresented: $showWebView, content: {
                        NavigationStack {
                            WebViewWithLoading(url: viewModel.selectedRepo.url!)
                        }
                    })
                    .listStyle(.plain)
                }
            }
        }
        .navigationTitle(viewModel.userName)
        .onAppear(perform: {
            viewModel.fetchUserDetails()
            viewModel.fetchUserRepos()
        })
        Spacer()
    }
}

//#Preview {
//    UserDetailsView()
//}
