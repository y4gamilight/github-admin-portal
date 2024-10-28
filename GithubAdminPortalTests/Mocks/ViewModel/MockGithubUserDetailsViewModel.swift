//
//  MockGithubUserDetailsViewModel.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import Foundation
@testable import GithubAdminPortal

final class MockGithubUserDetailsViewModel: GithubUserDetailsOutput {
  var fetchUserDetailsCalled = false

  func fetchUserDetails() {
    fetchUserDetailsCalled = true
  }
}
