//
//  Coordinator.swift
//  GithubApp
//
//  Created by Andres Mendieta on 19/01/24.
//

import SwiftUI

@MainActor
final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var page: MyPage = .list
    @Published var sheet: MySheet?
    @Published var currentUser: String?
    @Published var currentUrl: String?
    let repository = Repository()

    func goUsersList() {
        path.removeLast(path.count)
    }

    func goUserDetails(_ userName: String) {
        currentUser = userName
        path.append(MyPage.detail)
    }

    func goWebView() {
        sheet = .popup
    }

    @ViewBuilder
    func getPage(_ page: MyPage) -> some View {
        switch page {
            case .detail:
                let useCase = FetchUserDetailsUseCase(repository: repository)
                let viewModel = UserDetailsViewModel(userName: currentUser ?? "",
                                                     useCase: useCase)
                UserDetailsView(viewModel: viewModel)
            case .list:
                let useCase = FetchUsersUseCase(repository: repository)
                let viewModel = UsersViewModel(useCase: useCase)
                UsersView(viewModel: viewModel)
        }
    }

    
    func getSheet(_ sheet: MySheet) -> any View {
        switch sheet {
            case .popup:
                guard let url = URL(string: currentUrl ?? "") else {
                    return EmptyView()
                }

                return WebView(url: url)
        }
    }
}

enum MyPage: String, CaseIterable, Identifiable {
    case list, detail

    var id: String {self.rawValue}
}

enum MySheet: String, CaseIterable, Identifiable {
    case popup

    var id: String {self.rawValue}
}
