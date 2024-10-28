import XCTest
@testable import GithubAdminPortal

final class UserAPITests: XCTestCase {
  var sut: IUserAPI!
  
  override func setUp() {
    super.setUp()
    sut = MockUserAPI(provider: MockUserProvider())
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testGetAllUsersSuccess() {
    let expectation = self.expectation(description: "Get all users success")
    let request = GetUserListRequest(since: Constants.UserData.validId, perPage: 20)
    
    sut.getAll(request, onCompletion: { users in
      XCTAssertTrue(users.count > 0, "users must not be empty")
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected success but got failure with error: \(error)")
    })
    waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testGetUsersSuccessButEmptyData() {
    let expectation = self.expectation(description: "Get all users success")
    let request = GetUserListRequest(since: Constants.UserData.idWithEmptyData, perPage: 20)
    
    sut.getAll(request, onCompletion: { users in
      XCTAssertTrue(users.count == 0, "users must be empty")
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected success but got failure with error: \(error)")
    })
    waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testGetAllUsersFailure() {
    let expectation = self.expectation(description: "Get all users failure")
    let request = GetUserListRequest(since: Constants.UserData.invalidId, perPage: 20)
    
    
    sut.getAll(request, onCompletion: { users in
      XCTFail("Expected failure but got success with users: \(users)")
    }, onFailure: { error in
      XCTAssertNotNil(error, "Expecation is return error")
      expectation.fulfill()
    })
    waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testGetUserSuccess() {
    let expectation = self.expectation(description: "Get user info success")
    let request = GetUserDetailRequest(username: Constants.UserData.validUser)
    sut.getUser(request, onCompletion: { user in
      XCTAssertNotNil(user, "user must not be nil")
      expectation.fulfill()
    }, onFailure: { error in
      XCTFail("Expected success but got failure with error: \(error)")
    })
    
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetUserFailure() {
    let expectation = self.expectation(description: "Get user failure")
    let request = GetUserDetailRequest(username: Constants.UserData.invalidUser)
    sut.getUser(request, onCompletion: { user in
      XCTFail("Expected failure but got success with user: \(user)")
    }, onFailure: { error in
      XCTAssertNotNil(error, "Expecation is return error")
      expectation.fulfill()
    })
    
    waitForExpectations(timeout: 1, handler: nil)
  }
}
