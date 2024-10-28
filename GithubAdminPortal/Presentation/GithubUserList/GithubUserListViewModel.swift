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
    let response = userService.getLocalUsers()
//    userService.fetchAll(since: nil, onCompletion: {[weak self] response in
      let items = response.map { map($0) }
      DispatchQueue.main.async {
        self.input?.updateUsers(items)
      }
//    }) { error in
//      
//    }
  }
  
  private func map(_ element: GithubUser) -> GithubUserCellItem {
    return GithubUserCellItem(uid: "\(element.id)", userName: element.userName, profileURL: element.profileURL, avatarURL: element.avatarURL) {[weak self] profileURL in
      guard let this = self, let url = URL(string: profileURL) else { return }
      this.coordinator.presentWebView(url)
    }
  }
}

extension GithubUserListViewModel: GithubUserDataSourceListener {
  func onSelectedGithubUserCell(_ item: GithubUserCellItem) {
    coordinator.navigateToUser(item.userName)
  }
}
