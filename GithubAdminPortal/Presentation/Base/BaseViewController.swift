//
//  BaseViewController.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import UIKit

class BaseViewController: UIViewController {
  let container: DIContainer
  
  init(container: DIContainer) {
    self.container = container
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    configuration()
  }
  
  func setup() {}
  
  func configuration() {}
}
