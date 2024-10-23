//
//  BaseListResponse.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 23/10/24.
//

import Foundation

class BaseListResponse<Element: GPAResponse> {
  var items: [Element] = []
  
  init(from jsonData: Data) {
    do {
      let decoder = JSONDecoder()
      items = try decoder.decode([Element].self, from: jsonData)
    } catch (let error) {
      debugPrint("Thanhlt: \(error.localizedDescription)")
      items = []
    }
  }
}
