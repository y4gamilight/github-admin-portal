//
//  UserService.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import Foundation

final class UserService: IUserService {
  private let api: IUserAPI
  private let dataSource: IUserDataSource
  init(api: IUserAPI, dataSource: IUserDataSource) {
    self.api = api
    self.dataSource = dataSource
  }
  
  func getLocalUsers() -> [GithubUser] {
    return dataSource.getAll()
  }
  
  func getLocalUserByUserName(_ userName: String) -> GithubUserDetails? {
    return dataSource.getBelongTo(name: userName)
  }
  
  func fetchAll(since: Int?, perPage: Int, onCompletion: (([GithubUser]) -> Void)?, onFailure: ((APIError) -> Void)?) {
    let paramRequest = GetUserListRequest(since: since, perPage: perPage)
    api.getAll(paramRequest, onCompletion: {[weak self] response in
      guard let this = self else { return }
      this.saveUsersToLocal(response)
      let items = response.map { GithubUser(id: $0.id, avatarURL: $0.avatarUrl, userName: $0.login, profileURL: $0.htmlUrl) }
      onCompletion?(items)
    }, onFailure: { error in
      onFailure?(error)
    })
  }
  
  func fetchUserByUserName(_ userName: String, onCompletion: ((GithubUserDetails) -> Void)?, onFailure:((APIError) -> Void)?) {
    let paramRequest = GetUserDetailRequest(username: userName)
    api.getUser(paramRequest, onCompletion: {[weak self] response in
      guard let this = self else { return }
      this.saveUserDetailsToLocal(response)
      let userDetails = GithubUserDetails(userName: response.login, avatarURL: response.avatarUrl, profileURL: response.htmlUrl, location: response.location ?? "", followers: response.followers ?? 0, followings: response.following ?? 0, blog: response.blog ?? "")
      onCompletion?(userDetails)
    }, onFailure: { error in
      onFailure?(error)
    })
  }
  
  func saveUsersToLocal(_ models: [GithubUserResponseData]) {
    let dataSource = dataSource
    DispatchQueue.global(qos: .background).async {
      dataSource.save(models) { isComplete in
        debugPrint("Thanhlt stored \(isComplete)")
      }
    }
  }
  
  func saveUserDetailsToLocal(_ model: GithubUserResponseData) {
    let dataSource = dataSource
    DispatchQueue.global(qos: .background).async {
      dataSource.deleteAndSave([model]) { isComplete in
        debugPrint("Thanhlt override data \(isComplete)")
      }
    }
  }
}
