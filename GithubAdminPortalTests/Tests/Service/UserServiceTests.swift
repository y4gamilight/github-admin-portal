//
//  UserServiceTests.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import XCTest
import Foundation
@testable import GithubAdminPortal

final class UserServiceTests: XCTestCase {
  private var sut: IUserService!
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    sut = MockUserService()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    sut = nil
  }
  
  func testGetAllUserSuccess() throws {
    let expectation = self.expectation(description: "Test case get all user successfully ")
    sut.fetchAll(since: nil, perPage: 20) { users in
      XCTAssert(users.count == 20, "Number of items is 22")
      expectation.fulfill()
    } onFailure: { error in
      
    }
    waitForExpectations(timeout: 5.0)
  }

  func testGetUserDetail() throws {
    let expectation = self.expectation(description: "test get user detail success")
    sut.fetchUserByUserName(Constants.UserData.validUser) { userDetails in
      XCTAssert(userDetails.userName == Constants.UserData.validUser)
      expectation.fulfill()
    } onFailure: { error in
      
    }
    waitForExpectations(timeout: 5.0)
  }

  func testGetUserDetailByInvalidId() throws {
    let expectation = self.expectation(description: "test")
    sut.fetchUserByUserName(Constants.UserData.invalidUser) { userDetails in
    } onFailure: { error in
      var isNotFound = false
      if case .notFound = error {
        isNotFound = true
      }
      XCTAssertTrue(isNotFound, "Expectation is error not found")
      expectation.fulfill()
    }
    waitForExpectations(timeout: 5.0)
  }


  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
