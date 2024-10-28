//
//  GithubUserListViewModelTests.swift
//  GithubAdminPortalTests
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import XCTest
@testable import GithubAdminPortal

final class GithubUserListViewModelTests: XCTestCase {
  var sut: MockGithubUserListViewModel!
  
  override func setUp() {
    super.setUp()
    sut = MockGithubUserListViewModel()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testLoadDataInLoadedView() {
    sut.loadDataInLoadedView()
    
    XCTAssertTrue(sut.loadDataInLoadedViewCalled, "loadDataInLoadedViewCalled should be true")
  }
  
  func testRefreshList() {
    sut.refreshList()
    XCTAssertTrue(sut.refreshListCalled, "refreshListCalled should be true")
  }
}
