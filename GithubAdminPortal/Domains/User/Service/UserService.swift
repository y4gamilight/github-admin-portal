//
//  UserService.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import Foundation

final class UserService: IUserService {
  private let api: IAPIClient
  init(api: IAPIClient) {
    self.api = api
  }
  
  func getAll(since: Int?, completion: (([GithubUser]?, APIError?) -> Void)?) {
    let paramRequest = GetUserListRequest(since: since)
    api.excuteCollection(request: paramRequest) { (response: [GithubUserResponseData]) in
      let items = response.map { GithubUser(id: $0.id, avatarURL: $0.avatarUrl, userName: $0.login, profileURL: $0.htmlUrl) }
      completion?(items, nil)
    } failure: { error in 
      completion?(nil, error)
    }
  }
  
  func getUserByUserName(_ userName: String, completion: ((GithubUserDetails?, APIError?) -> Void)?) {
    let paramRequest = GetUserDetailRequest(username: userName)
    api.excute(request: paramRequest) { (response: GithubUserResponseData) in
      let userDetails = GithubUserDetails(userName: response.login, avatarURL: URL(string: response.avatarUrl), profileURL: response.htmlUrl, location: response.location ?? "", followers: response.followers ?? 0, followings: response.following ?? 0)
      completion?(userDetails, nil)
    } failure: { error in
      completion?(nil, error)
    }

  }
}
