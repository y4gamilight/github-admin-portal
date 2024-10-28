//
//  IUserService.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import Foundation

protocol IUserService {
  func getLocalUsers() -> [GithubUser]
  func fetchAll(since: Int?, onCompletion: (([GithubUser]) -> Void)?, onFailure: ((APIError) -> Void)?)
  func fetchUserByUserName(_ userName: String, onCompletion: ((GithubUserDetails) -> Void)?, onFailure:((APIError) -> Void)?)
}
