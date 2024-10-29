//
//  BaseViewController.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import UIKit

class BaseViewController<ViewModel: BaseViewModel>: UIViewController {
  let viewModel: ViewModel
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
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
  
  func showErorMessage(_ msg: String) {
      let alertVC = UIAlertController(title: "Github Admin Portal", message: msg, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title:  "Cancel", style: .cancel))
      self.present(alertVC, animated: true)
  }
}
