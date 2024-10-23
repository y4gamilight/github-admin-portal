//
//  GPARequest.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 23/10/24.
//

import Foundation

protocol GPARequest {
  associatedtype Response: GPAResponse 
  var path: String { get }
  var method: GPAHTTPMethod { get }
  var bodyData: Data? { get }
  var queries: [String: Any]? { get }
  var params: [String: Any]? { get }
  var headers: [String: String]? { get }
}

extension GPARequest {
  private var queryPathString: String? {
    get {
      guard let queries = self.queries, queries.count > 0 else { return nil }
      let strings: [String] = queries.reduce(into: [String]()) { $0.append("\($1.key)=\($1.value)") }
      let combineString = strings.joined(separator: "&")
      return combineString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
  }
  
  private func asHeaderRequest(_ headerDefault: [String: String]) -> [String: String] {
    guard let headers = headers else {
      return headerDefault
    }
    var newHeaders = headerDefault
    headers.forEach { key, value in
      newHeaders[key] = value
    }
    return newHeaders
  }
  
  var bodyData: Data? {
    guard let params = params else { return nil }
    return try? JSONSerialization.data(withJSONObject: params, options: [])
  }
  
  func asURLComponent(baseURL: String) -> URLComponents? {
    guard var urlComponents = URLComponents(string: baseURL) else { return nil }
    urlComponents.path = path
    urlComponents.query = queryPathString
    return urlComponents
  }
  
  func asUrlRequest(baseURL: String, headerDefault: [String: String]) -> URLRequest? {
    guard let url = asURLComponent(baseURL: baseURL)?.url else { return nil }
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.httpBody = bodyData
    request.allHTTPHeaderFields = headerDefault
    request.allHTTPHeaderFields = asHeaderRequest(headerDefault)
    return request
  }
}
