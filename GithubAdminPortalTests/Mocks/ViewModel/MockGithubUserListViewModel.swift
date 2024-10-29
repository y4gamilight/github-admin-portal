//
//  MockGithubUserListViewModel.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import Foundation
@testable import GithubAdminPortal

final class MockGithubUserListViewModel: GithubUserListOutput {
  var loadDataInLoadedViewCalled = false
  var refreshListCalled = false
  
  func loadDataInLoadedView() {
    loadDataInLoadedViewCalled = true
  }
  
  func refreshList() {
    refreshListCalled = true
  }
}
