//
//  ModelVersionType.swift
//  Migrations
//
//  Created by Florian on 06/10/15.
//  Copyright © 2015 objc.io. All rights reserved.
//

import CoreData


public protocol ModelVersionType: Equatable {
  static var AllVersions: [Self] { get }
  static var CurrentVersion: Self { get }
  var name: String { get }
  var modelBundle: NSBundle { get }
  var modelDirectoryName: String { get }
}

extension ModelVersionType {
  public init?(storeURL: NSURL) {
    guard let metadata = try? NSPersistentStoreCoordinator.metadataForPersistentStoreOfType(NSSQLiteStoreType, URL: storeURL, options: nil) else { return nil }
    let version = Self.AllVersions.findFirstOccurence {
      $0.managedObjectModel().isConfiguration(nil, compatibleWithStoreMetadata: metadata)
    }
    guard let result = version else { return nil }
    self = result
  }
  
  public func managedObjectModel() -> NSManagedObjectModel {
    let omoURL = modelBundle.URLForResource(name, withExtension: "omo", subdirectory: modelDirectoryName)
    let momURL = modelBundle.URLForResource(name, withExtension: "mom", subdirectory: modelDirectoryName)
    guard let url = omoURL ?? momURL else { fatalError("model version \(self) not found") }
    guard let model = NSManagedObjectModel(contentsOfURL: url) else { fatalError("cannot open model at \(url)") }
    
    return model
  }
}
