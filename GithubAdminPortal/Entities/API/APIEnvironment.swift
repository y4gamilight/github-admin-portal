//
//  APIEnvironment.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 23/10/24.
//

import Foundation

enum APIEnvironment {
  case dev
  case stg
  case production
  
  var baseURL: String {
    return "https://api.github.com"
  }
  
  var headerDefault: [String: String] {
    return [
      "Content-Type": "application/json;charset=utf-8",
      "Accept": "application/vnd.github+json",
      "X-Github-Api-Version": "2022-11-28",
      "Authorization": "<YOUR_TOKEN>"
    ]
  }
}
