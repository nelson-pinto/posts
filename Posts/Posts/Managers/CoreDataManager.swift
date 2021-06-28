//
//  CoreDataManager.swift
//  Posts
//
//  Created by Nelson Pinto on 27/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import Foundation
import CoreData

// CoreData manager for the Posts database
class CoreDataManager {
  static var shared = CoreDataManager()

  private init() {
    persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
  }

  // Context getter
  public var context: NSManagedObjectContext {
    get {
      return self.persistentContainer.viewContext
    }
  }

  // Post database context
  var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Posts")
    container.loadPersistentStores { (storeDescription, error) in
      guard error == nil else {
        NSLog("%s", error?.localizedDescription ?? "Failed to load persistent store")
        return
      }
    }
    return container
  }()

  // Save the database context if it has changes
  func save() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch let error {
        NSLog("%s", error.localizedDescription)
      }
    }
  }
}

