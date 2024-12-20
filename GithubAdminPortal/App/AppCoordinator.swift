//
//  AppCoordinator.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import UIKit

final class AppCoordinator: Coordinator {
  private let container: DIContainer
  private let window: UIWindow?
  
  lazy var rootViewController: UINavigationController = {
    let coordinator = GithubUserCoordinator(container: container)
    coordinator.parent = self
    addChild(coordinator)
    let childVC = coordinator.makeRootViewController()
    let navBar = RootNavController(rootViewController: childVC)
    navBar.navigationBar.isTranslucent = false
    return navBar
  }()
  
  // MARK: - Coordinator
  
  init(window: UIWindow?) {
    self.window = window
    self.container = DIContainer()
  }
  
  override func start() {
    setupDependencies()
    if let window = window {
      window.rootViewController = rootViewController
      window.makeKeyAndVisible()
    }
  }
  
  override func finsih() {
    container.release(type: IAPIClient.self)
    container.release(type: IUserService.self)
  }
  
  private func setupDependencies() {
    container.register(type: IAPIClient.self, service: APIClientImp(enviroment: .dev, urlSession: URLSession.shared))
    container.register(type: DatabaseManager.self, service: DatabaseManager.shared)
    
    if let apiClient = container.resolve(type: IAPIClient.self) {
      container.register(type: IUserAPI.self, service: UserAPI(api: apiClient))
    }
    if let databaseManager = container.resolve(type: DatabaseManager.self) {
      container.register(type: IUserDataSource.self, service: UserDataSource(databaseManager: databaseManager))
    }
    if let userAPI = container.resolve(type: IUserAPI.self),
       let userDataSource = container.resolve(type: IUserDataSource.self) {
      container.register(type: IUserService.self, service: UserService(api: userAPI, dataSource: userDataSource))
    }
  }
  
}
