//
//  ManagedObject.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 10/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

public class ManagedObject: NSManagedObject {
  
  public required init(managedObjectContext: NSManagedObjectContext) {
    let entityName = self.dynamicType.entityName
    
    let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)!
    
    super.init(entity: entity, insertInto: managedObjectContext)
  }
  
  @available(*, unavailable)
  private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
    super.init(entity: entity, insertInto: context)
  }

  public class func findOrCreate<T: ManagedObject>(withRequest fetchRequest: NSFetchRequest<T>, context: NSManagedObjectContext) -> T {
    guard let object = findUnique(withRequest: fetchRequest, context: context) else {
      return T(managedObjectContext: context)
    }
    
    return object
  }
  
  private class func findUnique<T: ManagedObject>(withRequest fetchRequest: NSFetchRequest<T>, context: NSManagedObjectContext) -> T? {
    fetchRequest.fetchLimit = 1
    
    do {
//      return (try context.fetch(fetchRequest)).first as? T

        let array: [T] = (try context.fetch(fetchRequest))

        return array.first
    } catch let error as NSError {
      print("Fetch failed: \(error.localizedDescription)")
    }
    
    return nil
  }
}
