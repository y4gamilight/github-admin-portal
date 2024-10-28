//
//  GithubUserListViewModel.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import Foundation

protocol GithubUserListOutput {
  func loadDataInLoadedView()
  func refreshList()
}

class GithubUserListViewModel: BaseViewModel { 
  var coordinator: GithubUserCoordinator
  weak var input: GithubUserListInput?
  private let userService: IUserService
  fileprivate var lastID: Int?
  fileprivate var isFetching: Bool = false
  fileprivate var items: [GithubUserCellItem] = []
  init(coordinator: GithubUserCoordinator, userService: IUserService) {
    self.coordinator = coordinator
    self.userService = userService
  }
}

extension GithubUserListViewModel: GithubUserListOutput {
  func loadDataInLoadedView() {
    items = userService.getLocalUsers().map { map($0) }
    DispatchQueue.main.async {
      self.input?.updateUsers(self.items)
    }
    refreshList()
  }
  
  func refreshList() {
    input?.stopLazyLoads()
    isFetching = false
    lastID = nil
    fetchUsers()
  }
  
  func fetchUsers(_ since: Int? = nil) {
    guard !isFetching else { return }
    isFetching = true
    
    userService.fetchAll(since: since, perPage: Constants.Pagination.perPage, onCompletion: { [weak self] response in
      guard let self = self else { return }
      
      if let newLastID = response.last?.id {
        if self.lastID == newLastID {
          self.isFetching = false
          return
        }
        self.lastID = newLastID
      }
      
      let items = response.map { self.map($0) }
      DispatchQueue.main.async {
        if since == nil {
          self.input?.updateUsers(items)
        } else {
          self.input?.appendUsers(items)
        }
        self.isFetching = false
        if response.count < Constants.Pagination.perPage {
          self.input?.stopLoadMore()
        }
      }
    }, onFailure: { [weak self] error in
      self?.isFetching = false
      self?.input?.stopLoadMore()
    })
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
  
  func onLoadMoreGithubUsers() {
    fetchUsers(lastID)
  }
}
