//
//  Localizationer.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 29/10/24.
//

import Foundation

struct Localizationer {
  static var appName: String { return localized("app_name") }
  static var textOk: String { return localized("text_ok") } 
  static var textFollower: String { return localized("text_follower") }
  static var textFollowing: String { return localized("text_following") }
  static var textBlog: String { return localized("text_blog") }
  static var headingUserList: String { return localized("heading_user_list") }
  static var headingUserDetail: String { return localized("heading_user_details") }
}

extension Localizationer {
  static func localized(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String = "") -> String {
    return NSLocalizedString(key, comment: comment)
  }
}
