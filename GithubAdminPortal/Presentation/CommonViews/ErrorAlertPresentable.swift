//
//  ViewShowingErrorable.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 29/10/24.
//

import UIKit

protocol ErrorAlertPresentable {
  func showErorMessage(_ msg: String)
}

extension ErrorAlertPresentable where Self: UIViewController {
  func showErorMessage(_ msg: String) {
    let alertVC = UIAlertController(title: Localizationer.appName, message: msg, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: Localizationer.textOk, style: .cancel))
    self.present(alertVC, animated: true)
  }
}

