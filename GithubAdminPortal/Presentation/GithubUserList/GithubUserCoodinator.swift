//
//  GithubUserCoordinator.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import UIKit

class GithubUserCoordinator: Coordinator {
  private let container: DIContainer
  private var rootViewController: UIViewController?
  init(container: DIContainer) {
    self.container = container
  }
  
  override func start() {
    
  }
  override func finsih() {
    
  }
  
  func makeRootViewController() -> UIViewController {
    guard let userService = container.resolve(type: IUserService.self) else {
      fatalError("User service hasn't registerd")
    }
    let viewModel = GithubUserListViewModel(coordinator: self, userService: userService)
    let vc = GithubUserListVC(viewModel: viewModel)
    viewModel.input = vc
    
    rootViewController = vc
    return vc
  }
  
  func navigateToUser(_ userName: String) {
    guard let userService = container.resolve(type: IUserService.self) else {
      fatalError("User service hasn't registerd")
    }
    let viewModel = GithubUserDetailsViewModel(coordinator: self, userName: userName, userService: userService)
    let vc = GithubUserDetailsVC(viewModel: viewModel)
    viewModel.input = vc
    rootViewController?.navigationController?.pushViewController(vc, animated: true)
  }
  
  func presentWebView(_ url: URL) {
    let webViewModel = WebViewModel(coordinator: self, url: url)
    let vc = WebVC(viewModel: webViewModel)
    webViewModel.input = vc
    rootViewController?.navigationController?.present(vc, animated: true)
  }
}
