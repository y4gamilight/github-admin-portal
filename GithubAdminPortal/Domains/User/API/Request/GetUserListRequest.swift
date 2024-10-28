//
//  GetUserListRequest.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan on 22/10/24.
//

struct GetUserListRequest: GPARequest {
  typealias Response = GithubUserResponseData
  enum Key: String {
    case since
    case perPage = "per_page"
  }
  
  var path: String = "/users"
  var method: GPAHTTPMethod = .get
  var headers: [String : String]? = nil
  var params: [String : Any]? = nil
  var queries: [String : Any]?

  init(since: Int?, perPage: Int) {
     self.queries = [ Key.perPage.rawValue: perPage]
     if let since = since {
       self.queries?[Key.since.rawValue] = since
     }
  }
}
