//
//  GithubUserDetailsViewModel.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//
import Foundation

protocol GithubUserDetailsOutput {
  func fetchUserDetails()
}

class GithubUserDetailsViewModel: BaseViewModel {
  var coordinator: GithubUserCoordinator
  weak var input: GithubUserDetailsInput?
  
  private let userName: String
  
  init(coordinator: GithubUserCoordinator, userName: String) {
    self.coordinator = coordinator
    self.userName = userName
  }
}

extension GithubUserDetailsViewModel: GithubUserDetailsOutput {
  func fetchUserDetails() {
    let userDetails = GithubUserDetails(userName: userName,
                                        avatarURL: "https://example.png",
                                        profileURL: "https://linkedin.con/in/\(userName)",
                                        location: "location_\(userName)",
                                        followers: userName.count,
                                        followings: userName.count)
    input?.updateUserDetails(user: userDetails)
  }
  
}
