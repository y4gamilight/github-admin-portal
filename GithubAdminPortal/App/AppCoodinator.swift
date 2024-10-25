//
//  AppCoodinator.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import UIKit

final class AppCoodinator {
  private let container: DIContainer
  private let window: UIWindow?
  
  lazy var rootViewController: UINavigationController = {
    let githubUserListVC = GithubUserListVC(container: container)
    return RootNavController(rootViewController: githubUserListVC)
  }()
  
  // MARK: - Coordinator
  
  init(window: UIWindow?) {
    self.window = window
    self.container = DIContainer()
  }
  
  func start() {
    guard let window = window else {
      return
    }
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }
  
  func finish() {
    
  }
  
  private func setupDependencies() {
    container.register(type: IAPIClient.self, service: APIClientImp(enviroment: .dev, urlSession: URLSession.shared))
  }
  
}
