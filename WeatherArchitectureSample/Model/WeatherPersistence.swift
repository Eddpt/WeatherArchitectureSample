//
//  WeatherPersistence.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 14/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

final class WeatherPersistence: ManagedObjectContextSettable {
  internal var managedObjectContext: NSManagedObjectContext!
  
  required init(managedObjectContext: NSManagedObjectContext) {
    self.managedObjectContext = managedObjectContext
  }
  
  func persistWeather(withData data: JSONDictionary) {
    managedObjectContext.performBlockAndWait {
      
      guard let dataArray = data["list"] as? [JSONDictionary] else {
        return
      }
      
      for dataDictionary in dataArray {
        guard let recordDate = dataDictionary["dt"] as? Double else { continue }
        let recordDatePredicate = NSPredicate(format: "recordDate == %@", NSDate(timeIntervalSince1970: recordDate))
        let fetchRequest = FetchRequest<WeatherRecord>(predicate: recordDatePredicate, context: self.managedObjectContext)
        
        let weatherRecord = WeatherRecord.findOrCreate(withRequest: fetchRequest, context: self.managedObjectContext)
        let _ = try? weatherRecord.updateWithJSONDictionary(dataDictionary)
      }
    }
  }
}