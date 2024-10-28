//
//  MockUserService.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import Foundation

@testable import GithubAdminPortal

class MockUserService: IUserService {
  func getLocalUsers() -> [GithubUser] {
    return []
  }
  
  func getLocalUserByUserName(_ userName: String) -> GithubUserDetails? {
    return nil
  }
  
  func fetchAll(since: Int?, perPage: Int, onCompletion: (([GithubUser]) -> Void)?, onFailure: ((APIError) -> Void)?) {
    let source: String = since == Constants.UserData.idWithEmptyData ? "empty_array" : "users"
    let bundle = Bundle(for: MockUserService.self)
    let items: [GithubUserResponseData]? = JSONFileHelper.readJSONFile(fileName: source, bundle: bundle)
    let startIndex = items?.firstIndex { $0.id == since } ?? 0
    let endIndex = min(startIndex + perPage, items?.count ?? 0)
    let paginatedItems = items?[startIndex..<endIndex] ?? []
    let users: [GithubUser] = paginatedItems.map { GithubUser(id: $0.id, avatarURL: $0.avatarUrl, userName: $0.login, profileURL: $0.htmlUrl) } ?? []
    if users.isEmpty {
      onFailure?(APIError.notFound)
    } else {
      onCompletion?(users)
    }
  }
  
  func fetchUserByUserName(_ userName: String, onCompletion: ((GithubUserDetails) -> Void)?, onFailure: ((APIError) -> Void)?) {
    if userName == Constants.UserData.invalidUser {
      onFailure?(APIError.notFound)
      return
    }
    let bundle = Bundle(for: MockUserService.self)
    let response: GithubUserResponseData? = JSONFileHelper.readJSONFile(fileName: "valid_user", bundle: bundle)
    if let item = response {
      let user = GithubUserDetails(userName: item.login,
                                   avatarURL: item.avatarUrl,
                                   profileURL: item.htmlUrl,
                                   location: item.location ?? "",
                                   followers: item.followers ?? 0,
                                   followings: item.following ?? 0,
                                   blog: item.blog ?? item.bio ?? "")
      onCompletion?(user)
    } else {
      onFailure?(APIError.notFound)
    }
  }
}
