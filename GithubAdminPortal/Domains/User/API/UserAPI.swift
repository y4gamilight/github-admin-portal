//
//  UserAPI.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 28/10/24.
//

import Foundation

final class UserAPI: IUserAPI {
  private let api: IAPIClient
  init(api: IAPIClient) {
    self.api = api
  }
  
  func getAll(_ request: GetUserListRequest,
              onCompletion: (([GithubUserResponseData]) -> Void)?,
              onFailure: ((APIError) -> Void)?) {
    api.excuteCollection(request: request) { response in
      onCompletion?(response)
    } failure: { error in
      onFailure?(error)
    }
  }
  
  func getUser(_ request: GetUserDetailRequest,
               onCompletion: ((GithubUserResponseData) -> Void)?,
               onFailure:((APIError) -> Void)?) {
    api.excute(request: request) { response in
      onCompletion?(response)
    } failure: { error in
      onFailure?(error)
    }
  }
}
