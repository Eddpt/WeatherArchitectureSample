//
//  WeatherRecord.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 08/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

@objc(WeatherRecord)

public final class WeatherRecord: ManagedObject {
  @NSManaged public private(set) var recordDate: NSDate
  @NSManaged public private(set) var minTemperature: Double
  @NSManaged public private(set) var maxTemperature: Double
}

class InvalidDataError: ErrorType { }

extension WeatherRecord: JSONMappable {
  func updateWithJSONDictionary(jsonDictionary: JSONDictionary) throws -> Self {
    guard let
      recordDate = jsonDictionary["dt"] as? Double,
      temperatureDictionary = jsonDictionary["temp"] as? JSONDictionary,
      minTemperature = temperatureDictionary["min"] as? Double,
      maxTemperature = temperatureDictionary["max"] as? Double
      else { throw InvalidDataError() }
    
    self.recordDate = NSDate(timeIntervalSince1970: recordDate)
    self.minTemperature = minTemperature
    self.maxTemperature = maxTemperature
    
    return self
  }
}