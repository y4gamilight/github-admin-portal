//
//  GithubUserListViewModel.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import Foundation

protocol GithubUserListOutput {
  func fetchUsers()
}

class GithubUserListViewModel: BaseViewModel { 
  var coordinator: GithubUserCoordinator
  weak var input: GithubUserListInput?
  private let userService: IUserService
  init(coordinator: GithubUserCoordinator, userService: IUserService) {
    self.coordinator = coordinator
    self.userService = userService
  }
}

extension GithubUserListViewModel: GithubUserListOutput {
  func fetchUsers() {
    userService.getAll(since: nil) {[weak self] response, error in
      guard let response = response else {
        return
      }
      let items = response.map { element in
        let url = URL(string: element.avatarURL)
        return GithubUserItemCell(uid: "\(element.id)", userName: element.userName, profileURL: element.profileURL, imageURL: url)
      }
      DispatchQueue.main.async {
        self?.input?.updateUsers(items)
      }
    }
  }
}

extension GithubUserListViewModel: GithubUserDataSourceListener {
  func onSelectedGithubUserCell(_ item: GithubUserItemCell) {
    coordinator.navigateToUser(item.userName)
  }
}
