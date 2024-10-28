//
//  RootNavController.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 22/10/24.
//

import UIKit

class RootNavController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = Colors.primaryBg
    navigationBar.barTintColor = Colors.primaryBg
    navigationBar.backgroundColor = Colors.primaryBg
    navigationBar.tintColor = Colors.primaryContent
    navigationBar.titleTextAttributes =  [.foregroundColor: Colors.primaryContent]
  }
}

