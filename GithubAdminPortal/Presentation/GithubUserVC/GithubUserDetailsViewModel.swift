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
  weak var input: (GithubUserDetailsInput & ViewLoadable & ErrorAlertPresentable)?
  
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
    var hasCaching = false
    if let userDetails = userService.getLocalUserByUserName(userName) {
      hasCaching = true
      DispatchQueue.main.async {
        self.input?.updateUserDetails(user: userDetails)
      }
    }
    input?.showLoading()
    userService.fetchUserByUserName(userName, onCompletion: {[weak self] userDetails in
      DispatchQueue.main.async {
        self?.input?.updateUserDetails(user: userDetails)
        self?.input?.hideLoading()
      }
    }, onFailure: {[weak self] error in
      DispatchQueue.main.async {
        self?.input?.hideLoading()
        if !hasCaching {
          self?.input?.showErorMessage(error.description)
        }
      }
    })
  }
}

