//
//  IUserAPI.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 28/10/24.
//

import Foundation

protocol IUserAPI {
  func getAll(_ request: GetUserListRequest,
              onCompletion: (([GithubUserResponseData]) -> Void)?,
              onFailure: ((APIError) -> Void)?)
  func getUser(_ request: GetUserDetailRequest,
               onCompletion: ((GithubUserResponseData) -> Void)?,
               onFailure:((APIError) -> Void)?)
}
