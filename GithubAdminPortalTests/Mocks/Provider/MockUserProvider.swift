//
//  MockUserProvider.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import Foundation

@testable import GithubAdminPortal

final class MockUserProvider {
  private let bundle: Bundle = Bundle(for: MockUserService.self)
  
  var emptyUsers: [GithubUserResponseData] {
    let items: [GithubUserResponseData]? = JSONFileHelper.readJSONFile(fileName: "empty_array", bundle: bundle)
    return items ?? []
  }

  var users: [GithubUserResponseData] {
    let items: [GithubUserResponseData]? = JSONFileHelper.readJSONFile(fileName: "users", bundle: bundle)
    return items ?? []
  }
  
  var userDetails: GithubUserResponseData {
    let response: GithubUserResponseData = JSONFileHelper.readJSONFile(fileName: "valid_user", bundle: bundle)!
    return response
  }
    
}
