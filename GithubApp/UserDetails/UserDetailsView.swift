//
//  UserDetailsView.swift
//  GithubApp
//
//  Created by Andres Mendieta on 16/01/24.
//

import SwiftUI

struct UserDetailsView: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: UserDetailsViewModel
    @State private var showWebView = false

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.model.iconImage)) { phase in
                if let image = phase.image {
                    image.resizable()
                } else if phase.error != nil {
                    Image(systemName: "person.fill")
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
                    WebView(url: viewModel.selectedRepo.url!)
                        .ignoresSafeArea()
                        .navigationTitle(viewModel.selectedRepo.name)
                        .navigationBarTitleDisplayMode(.inline)
                }
            })
            .listStyle(.plain)
        }
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
