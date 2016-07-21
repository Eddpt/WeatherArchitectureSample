//
//  NSManagedObjectContext+Extensions.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 09/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
  public convenience init<Version: ModelVersionType>(concurrencyType: NSManagedObjectContextConcurrencyType, modelVersion: Version, storeURL: URL) {
    let psc = NSPersistentStoreCoordinator(managedObjectModel: modelVersion.managedObjectModel())
    try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
    self.init(concurrencyType: concurrencyType)
    persistentStoreCoordinator = psc
  }
  
  public func saveContext() {
    if !hasChanges {
      return
    }
    
    do {
      try save()
    } catch {
      rollback()
    }
  }
}
