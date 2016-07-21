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
  @NSManaged public private(set) var recordDate: Date
  @NSManaged public private(set) var minTemperature: Double
  @NSManaged public private(set) var maxTemperature: Double
}

class InvalidDataError: ErrorProtocol { }

extension WeatherRecord: JSONMappable {
  func updateWithJSONDictionary(_ jsonDictionary: JSONDictionary) throws -> Self {
    guard let recordDate = jsonDictionary["dt"] as? Double,
          let temperatureDictionary = jsonDictionary["temp"] as? JSONDictionary,
          let minTemperature = temperatureDictionary["min"] as? Double,
          let maxTemperature = temperatureDictionary["max"] as? Double
      else { throw InvalidDataError() }
    
    self.recordDate = Date(timeIntervalSince1970: recordDate)
    self.minTemperature = minTemperature
    self.maxTemperature = maxTemperature
    
    return self
  }
}
