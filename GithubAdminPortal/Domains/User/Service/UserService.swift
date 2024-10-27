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
}
