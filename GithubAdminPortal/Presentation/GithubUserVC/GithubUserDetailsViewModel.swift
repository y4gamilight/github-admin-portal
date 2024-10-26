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
  var coordinator: AppCoodinator
  weak var input: GithubUserDetailsInput?
  
  init(coordinator: AppCoodinator) {
    self.coordinator = coordinator
  }
}

extension GithubUserDetailsViewModel: GithubUserDetailsOutput {
  func fetchUserDetails() {
  }
  
}
