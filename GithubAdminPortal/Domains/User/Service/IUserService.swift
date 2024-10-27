//
//  IUserService.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import Foundation

protocol IUserService {
  func getAll(since: Int?, completion: (([GithubUser]?, APIError?) -> Void)?)
  func getUserByUserName(_ userName: String, completion: ((GithubUserDetails?, APIError?) -> Void)?)
}
