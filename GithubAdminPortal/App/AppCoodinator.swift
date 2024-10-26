//
//  AppCoodinator.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import UIKit

final class AppCoodinator: Coordinator {
  private let container: DIContainer
  private let window: UIWindow?
  
  lazy var rootViewController: UINavigationController = {
    return RootNavController(rootViewController: githubUserListVC)
  }()
  
  private var githubUserListVC: GithubUserListVC {
    let viewModel = GithubUserListViewModel(coordinator: self)
    let vc = GithubUserListVC(viewModel: viewModel)
    
    viewModel.input = vc
    return vc
  }
  
  // MARK: - Coordinator
  
  init(window: UIWindow?) {
    self.window = window
    self.container = DIContainer()
  }
  
  override func start() {
    guard let window = window else {
      return
    }
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }
  
  override func finsih() {
    
  }
  
  private func setupDependencies() {
    container.register(type: IAPIClient.self, service: APIClientImp(enviroment: .dev, urlSession: URLSession.shared))
  }
  
}
