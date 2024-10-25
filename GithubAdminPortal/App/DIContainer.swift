//
//  DIContainer.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import Foundation

final class DIContainer {
  private var services: [String: Any] = [:]
  
  func register<Service>(type: Service.Type, service: Service) {
      let key = String(describing: type)
      services[key] = service
  }
  
  func resolve<Service>(type: Service.Type) -> Service? {
      let key = String(describing: type)
      return services[key] as? Service
  }
  
  @discardableResult
  func release<Service>(type: Service.Type) -> Bool {
    let key = String(describing: type)
    services.removeValue(forKey: key)
    return true
  }
}
