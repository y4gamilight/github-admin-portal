//
//  DIContainer.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 27/10/24.
//

import UIKit

struct Images {
  enum Name: String {
    case icAvaDefault = "ic_default_user"
    case icError = "ic_error"
    case icFollowers = "ic_followers"
    case icLocation = "ic_location"
    case icFollowings = "ic_archivement"
    case icClose = "ic_close"
  }
  
  static func image(_ image: Name) -> UIImage? {
    return UIImage(named: image.rawValue)
  }
}
