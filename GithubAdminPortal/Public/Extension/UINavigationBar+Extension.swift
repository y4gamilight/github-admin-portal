//
//  UINavigationBar+Extension.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 28/10/24.
//

import UIKit

extension UINavigationBar {
  func hideBackTitle() {
    if #available(iOS 14.0, *) {
      topItem?.backButtonDisplayMode = .minimal
    } else if #available(iOS 13.0, *) {
      let newAppearance = standardAppearance.copy()
      newAppearance.backButtonAppearance.normal.titleTextAttributes = [
        .foregroundColor: UIColor.clear,
        .font: UIFont.systemFont(ofSize: 0)
      ]
      standardAppearance = newAppearance
    } else {
      topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
  }
}
