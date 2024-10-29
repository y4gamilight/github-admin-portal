//
//  GithubUserDetailsViewModelTests.swift
//  GithubAdminPortalTests
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import XCTest
@testable import GithubAdminPortal

final class GithubUserDetailsViewModelTests: XCTestCase {
  var sut: MockGithubUserDetailsViewModel!
  
  override func setUp() {
    super.setUp()
    sut = MockGithubUserDetailsViewModel()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testFetchUserDetails() {
    sut.fetchUserDetails()
    XCTAssertTrue(sut.fetchUserDetailsCalled, "fetchUserDetailsCalled should be true")
  }
}
