//
//  IAPIClient.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 23/10/24.
//

import Foundation

typealias APICompletionSingleResult = ((GPAResponse) -> Void)
typealias APICompletionCollectionResult = (([GPAResponse]) -> Void)
typealias APIFailureHandler = ((APIError) -> Void)

protocol IAPIClient {
  func excute<R: GPARequest>(request: R, completion: @escaping APICompletionSingleResult, failure: @escaping APIFailureHandler)
  func excuteCollection<R: GPARequest>(request: R, completion: @escaping APICompletionCollectionResult, failure: @escaping APIFailureHandler)
}
