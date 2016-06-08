//
//  FetchRequest.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 14/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

public class FetchRequest<T: ManagedObject>: NSFetchRequest {
  
  // MARK: Initialization
  
  public required init(predicate: NSPredicate, context: NSManagedObjectContext) {
    super.init()
    self.entity = NSEntityDescription.entityForName(T.entityName, inManagedObjectContext: context)
    self.predicate = predicate
  }
}
