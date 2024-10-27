//
//  GetUserDetailRequest.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 27/10/24.
//

import Foundation

struct GetUserDetailRequest: GPARequest {
  typealias Response = GithubUserResponseData
  
  var path: String = "/users"
  var method: GPAHTTPMethod = .get
  var headers: [String : String]? = nil
  var params: [String : Any]? = nil
  var queries: [String : Any]?

  init(username: String) {
    self.path = "\(path)/\(username)"
  }
}
