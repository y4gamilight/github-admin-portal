//
//  MockUserAPI.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import Foundation

@testable import GithubAdminPortal

final class MockUserAPI: IUserAPI {
  private var provider: MockUserProvider
  init(provider: MockUserProvider) {
    self.provider = provider
  }

  func getAll(_ request: GetUserListRequest,
              onCompletion: (([GithubUserResponseData]) -> Void)?,
              onFailure: ((APIError) -> Void)?) {
    if request.queries?[GetUserListRequest.Key.since.rawValue] as? Int == Constants.UserData.invalidId {
      onFailure?(APIError.notFound)
      return
    } else if request.queries?[GetUserListRequest.Key.since.rawValue] as? Int == Constants.UserData.idWithEmptyData {
      onCompletion?(provider.emptyUsers)
    } else {
      onCompletion?(provider.users)
    }           
  }

  func getUser(_ request: GetUserDetailRequest,
               onCompletion: ((GithubUserResponseData) -> Void)?,
               onFailure:((APIError) -> Void)?) {
    if request.path.components(separatedBy: "/").last as? String == Constants.UserData.invalidUser {
      onFailure?(APIError.notFound)
      return
    } else {
      onCompletion?(provider.userDetails)
    }  
  } 
}
