//
//  UIView+Extension.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 25/10/24.
//

import UIKit

extension UIView {
  @discardableResult
  func forAutolayout() -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    return self
  }

  var safeTopAnchor: NSLayoutYAxisAnchor {
    return self.safeAreaLayoutGuide.topAnchor
  }

  var safeLeftAnchor: NSLayoutXAxisAnchor {
    return self.safeAreaLayoutGuide.leftAnchor
  }

  var safeRightAnchor: NSLayoutXAxisAnchor {
    return self.safeAreaLayoutGuide.rightAnchor
  }

  var safeBottomAnchor: NSLayoutYAxisAnchor {
    return self.safeAreaLayoutGuide.bottomAnchor
  }
}