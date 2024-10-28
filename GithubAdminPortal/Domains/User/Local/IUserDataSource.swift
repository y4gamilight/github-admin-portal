//
//  IUserDataSource.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

protocol IUserDataSource {
  func getAll() -> [GithubUser]
  func getBelongTo(name userName: String) -> GithubUserDetails?
  func save(_ models: [GithubUserResponseData], completion: @escaping (Bool) -> Void)
}
