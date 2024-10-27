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
  private let userService: IUserService
  
  init(coordinator: GithubUserCoordinator, userName: String, userService: IUserService) {
    self.coordinator = coordinator
    self.userName = userName
    self.userService = userService
  }
}

extension GithubUserDetailsViewModel: GithubUserDetailsOutput {
  func fetchUserDetails() {
    userService.getUserByUserName(userName) {[weak self] userDetails, error in
      guard let userDetails = userDetails else {
        return
      }
      DispatchQueue.main.async {
        self?.input?.updateUserDetails(user: userDetails)
      }
    }
  }
  
}
