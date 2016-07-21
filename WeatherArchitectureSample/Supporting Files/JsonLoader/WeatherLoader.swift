//
//  WeatherLoader.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 08/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation
import CoreData

/**
 *  TEST CODE
 */
struct WeatherLoader {
  
  static func allWeatherRecords(_ managedObjectContext: NSManagedObjectContext) -> [WeatherRecord] {
    var weatherRecords : [WeatherRecord] = []
    
    managedObjectContext.performAndWait {
      
      guard let path = Bundle.main.pathForResource("WeatherRecords", ofType: "json"),
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)),
        let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary,
        let jsonResultArray = jsonResult!["list"] as? NSArray else { return }
      
      weatherRecords = jsonResultArray.flatMap({ (weatherRecordResult) -> WeatherRecord? in
        let weatherRecord = WeatherRecord(managedObjectContext: managedObjectContext)
        guard let object = try? weatherRecord.updateWithJSONDictionary(weatherRecordResult as! [String : AnyObject]) else { fatalError("Impossible to parse") }
        
        return object
      })
    }
    
    return weatherRecords
  }
}
