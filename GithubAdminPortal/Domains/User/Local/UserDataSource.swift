//
//  UserDataSource.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//
import Foundation
import CoreData

class UserDataSource: IUserDataSource {
  private let databaseManager: DatabaseManager
  private var bgContext: NSManagedObjectContext
  private var entity: NSEntityDescription?
  private var context: NSManagedObjectContext { databaseManager.context }
  
  init(databaseManager: DatabaseManager) {
    self.databaseManager = databaseManager
    self.bgContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    self.bgContext.parent = context
    self.entity = NSEntityDescription.entity(forEntityName: "GithubUserEntity", in: context)
  }
  
  func getAll() -> [GithubUser] {
    let fetchRequest = GithubUserEntity.fetchRequest()
    do {
      let objects = try context.fetch(fetchRequest)
      return objects.compactMap { map($0) }
    } catch {
      assertionFailure("Fetch list github users failure ")
    }
    return []
  }
  
  func getBelongTo(name userName: String) -> GithubUserDetails? {
    let fetchRequest = GithubUserEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(
      format: "login == %@", userName
    )
    do {
      let objects = try context.fetch(fetchRequest)
      if let firstObject = objects.first {
        return mapDetail(firstObject)
      }
      return nil
    } catch {
      assertionFailure("Fetch github users belong to name \(userName) failure")
    }
    return nil
  }
  
  func deleteAndSave(_ models: [GithubUserResponseData], completion: @escaping (Bool) -> Void) {
    bgContext.performAndWait {[weak self] in
      guard let this = self else {
        completion(false)
        return
      }
      this.performDelete(entities: models.map { $0.login}, completion: {[weak self] isComplete in
        guard let this = self else {
          completion(false)
          return
        }
        this.performSave(models, completion: completion)
      })
    }
  }
  
  func performDelete(entities: [String], completion: @escaping (Bool) -> Void) {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "GithubUserEntity")
     fetchRequest.predicate = NSPredicate(format: "login IN %@", entities)
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
      try bgContext.execute(batchDeleteRequest)
      bgContext.reset()
      completion(true)
    } catch {
      completion(false)
      assertionFailure("Delete github users failure")
    }
  }
  
  func performSave(_ models: [GithubUserResponseData], completion: @escaping (Bool) -> Void) {
    for model in models {
      let entity = GithubUserEntity(context: bgContext)
      entity.id = Int32(model.id)
      entity.login = model.login
      entity.name = model.name
      entity.avatarURL = model.avatarUrl
      entity.htmlURL = model.htmlUrl
      entity.location = model.location
      entity.followers = Int32(model.followers ?? 0)
      entity.following = Int32(model.following ?? 0)
      entity.bio = model.bio
      entity.blog = model.blog
      entity.company = model.company
      entity.createdAt = model.createdAt
      entity.updatedAt = model.updatedAt
      entity.email = model.email
      entity.url = model.url
      entity.reposUrl = model.reposUrl
      entity.gistsURL = model.gistsUrl
    }
    do {
      try bgContext.save()
      databaseManager.saveContext { isComplete in
        completion(isComplete)
      }
    } catch {
      assertionFailure("Failed to save background context: \(error)")
      completion(false)
    }
  }
  
  func save(_ models: [GithubUserResponseData], completion: @escaping (Bool) -> Void) {
    bgContext.performAndWait {[weak self] in
      guard let this = self else {
        completion(false)
        return
      }
      this.performSave(models, completion: completion)
    }
  }
  
  private func map(_ entity: GithubUserEntity) -> GithubUser? {
    guard let userName = entity.login else { return nil }
    return GithubUser(id: Int(entity.id),
                      avatarURL: entity.avatarURL ?? "",
                      userName: userName,
                      profileURL: entity.htmlURL ?? "")
  }
  
  private func mapDetail(_ entity: GithubUserEntity) -> GithubUserDetails? {
    return GithubUserDetails(userName: entity.login ?? "",
                             avatarURL: entity.avatarURL,
                             profileURL: entity.htmlURL ?? "",
                             location: entity.location ?? "",
                             followers: Int(entity.followers),
                             followings: Int(entity.following),
                             blog: entity.blog ?? entity.bio ?? "")
  }
}
