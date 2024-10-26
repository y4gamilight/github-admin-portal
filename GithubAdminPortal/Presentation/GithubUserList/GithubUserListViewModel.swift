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
  init(coordinator: GithubUserCoordinator) {
    self.coordinator = coordinator
  }
}

extension GithubUserListViewModel: GithubUserListOutput {
  func fetchUsers() {
    let items = (1...20).map { i in
      GithubUserItemCell(uid: "uid_\(i)", userName: "user\(i)", profileURL: "https://linkedin/user\(i)", imageView: URL(string: "https://example.com/avatar\(i).png"))
    }
    input?.updateUsers(items)
  }
}

extension GithubUserListViewModel: GithubUserDataSourceListener {
  func onSelectedGithubUserCell(_ item: GithubUserItemCell) {
    coordinator.navigateToUser(item.userName)
  }
}
