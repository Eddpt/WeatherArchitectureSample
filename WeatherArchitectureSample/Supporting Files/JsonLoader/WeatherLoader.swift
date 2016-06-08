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
  
  static func allWeatherRecords(managedObjectContext: NSManagedObjectContext) -> [WeatherRecord] {
    var weatherRecords : [WeatherRecord] = []
    
    managedObjectContext.performBlockAndWait {
      
      guard let path = NSBundle.mainBundle().pathForResource("WeatherRecords", ofType: "json"),
        jsonData = NSData(contentsOfFile: path),
        jsonResult = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary,
        jsonResultArray = jsonResult!["list"] as? NSArray else { return }
      
      weatherRecords = jsonResultArray.flatMap({ (weatherRecordResult) -> WeatherRecord? in
        let weatherRecord = WeatherRecord(managedObjectContext: managedObjectContext)
        guard let object = try? weatherRecord.updateWithJSONDictionary(weatherRecordResult as! [String : AnyObject]) else { fatalError("Impossible to parse") }
        
        return object
      })
    }
    
    return weatherRecords
  }
}