//
//  ViewLoadable.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 29/10/24.
//

import UIKit

protocol ViewLoadable {
  func showLoading()
  func hideLoading()
}

extension ViewLoadable where Self: UIViewController {
  func showLoading() {
    let topView: UIView = tabBarController?.view ?? (navigationController?.view ?? view)
    HudLoadingView.shared.show(in: topView)
  }
  
  func hideLoading() {
    HudLoadingView.shared.hide()
  }
}
