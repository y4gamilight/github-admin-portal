//
//  DatabaseManager.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 23/10/24.
//

import Foundation
import CoreData

final class DatabaseManager {
  static let shared = DatabaseManager()
  
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "GithubAdminPortal")
    container.loadPersistentStores { store, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  func saveContext() {
    guard persistentContainer.viewContext.hasChanges else { return }
    do {
      try persistentContainer.viewContext.save()
    } catch (let error) {
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }
}
