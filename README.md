# GithubApp
The application was created following principles of clean architecture and SOLID principles. It includes unit tests, error handling, and loading screens. No external libraries are used, and the views were created using SwiftUI.

![](https://github.com/camyoh/GithubAppTest/blob/main/Videos/video1.gif) ![](https://github.com/camyoh/GithubAppTest/blob/main/Videos/video2.gif)

This app displays a list of GitHub users with their avatars and usernames. The app uses async/await for network requests and features pagination for fetching additional users.

## ListView
The ListView struct represents the main view of the app. It utilizes a ListViewModel to manage the data and fetch GitHub users. The view includes a loading indicator, error handling, and a navigation stack for transitioning to user details.

## ListViewModel
The ListViewModel class is an ObservableObject responsible for managing the state of the user list. It communicates with a FetchUsersUseCase to fetch GitHub users, handles pagination, and provides data for the ListView. Error handling and navigation to user details are also handled by this class.

## UserModel
The UserModel struct defines the properties of a GitHub user, including an identifier, avatar URL, and username. It conforms to the Equatable and Identifiable protocols.

## FetchUsersUseCase
The FetchUsersUseCase class implements the FetchUsersUseCaseProtocol, fetching GitHub users from a repository. It utilizes async/await to handle asynchronous network requests.

# GitHub User Details View
The UserDetailsView SwiftUI structure is designed to display detailed information about a GitHub user, including user details and repositories. It uses an ObservableObject, UserDetailsViewModel, to manage the data fetching and presentation.

## UserDetailsView Structure
User Details Section: Displays user details such as the user's profile image, full name, number of followers, and number of following.
User Repositories Section: Lists the repositories owned by the user, including details like the repository name, language, stars, and description. Users can tap on a repository to view it in a WebView.
WebView With Loading: Displays a WebView for viewing the selected repository with an optional loading indicator.
## UserDetailsViewModel Class
Model: Stores user details, repository models, loading indicators, and errors.
Methods: Provides methods to fetch user details and repositories asynchronously using a FetchUserDetailsUseCase.
Error Handling: Handles errors during data fetching and provides a method to display error views.
## UserDetailsModel Structure
Represents the model for a GitHub user's details, including their profile image, username, full name, number of followers, and number of following.

## UserRepoModel Class
Represents the model for a GitHub user's repository, including the repository's ID, name, language, number of stars, description, and URL.

## FetchUserDetailsUseCaseProtocol & FetchUserDetailsUseCase
Protocol: Defines methods to fetch user details and repositories asynchronously.
UseCase Class: Implements the protocol and fetches user details and repositories using a provided repository.

# GitHub API Repository and Networking
The provided code defines a set of protocols and classes for interacting with the GitHub API, handling data decoding, and managing network requests.

## RepositoryProtocol
The RepositoryProtocol outlines the methods required for fetching GitHub users, user details, and user repositories. These methods are expected to be implemented by any concrete repository class.

## Repository Class
The Repository class conforms to the RepositoryProtocol. It utilizes an ApiClientProtocol for making network requests and a DataDecoderProtocol for decoding the received data. The class fetches information about GitHub users, user details, and user repositories by constructing appropriate URLs.

## ApiClientProtocol
The ApiClientProtocol defines the method for fetching data from a given URL asynchronously.

## URLSessionAPIClient Class
The URLSessionAPIClient class implements the ApiClientProtocol using the URLSession framework. It fetches data from a URL and handles common networking errors, such as no internet connectivity or a failed request.

## DataDecoderProtocol
The DataDecoderProtocol outlines the method for decoding data into a specified type conforming to the Decodable protocol.

## JSONDecoderWrapper Class
The JSONDecoderWrapper class implements the DataDecoderProtocol using the JSONDecoder. It handles the decoding of data received from the GitHub API.

## GithubAPIError
The GithubAPIError enum defines various errors that can occur during API interactions, including invalid URLs, failed requests, invalid responses, decoding errors, and lack of internet connectivity. 
