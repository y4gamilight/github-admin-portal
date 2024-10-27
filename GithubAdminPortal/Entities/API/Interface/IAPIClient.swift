//
//  IAPIClient.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 23/10/24.
//

import Foundation
typealias APIFailureHandler = ((APIError) -> Void)

protocol IAPIClient {
  func excute<R: GPARequest>(request: R, completion: @escaping (R.Response) -> Void, failure: @escaping APIFailureHandler)
  func excuteCollection<R: GPARequest>(request: R, completion: @escaping ([R.Response]) -> Void, failure: @escaping APIFailureHandler)
}
