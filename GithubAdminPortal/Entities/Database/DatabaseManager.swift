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
    
  var context: NSManagedObjectContext {
    persistentContainer.viewContext
  }
  
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "GithubAdminPortal")
    container.loadPersistentStores { store, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  func saveContext(_ completion: @escaping (Bool) -> Void) {
    guard context.hasChanges else {
      completion(true)
      return
    }
    context.performAndWait {[weak self] in
      do {
        try self?.context.save()
        completion(true)
      } catch {
        assertionFailure("Failed to save context: \(error)")
        completion(false)
      }
    }
  }
}
