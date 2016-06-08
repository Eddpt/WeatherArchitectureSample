//
//  WeatherStack.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 09/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

public func createWeatherMainContext() -> NSManagedObjectContext? {
  return NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType, modelVersion: WeatherModelVersion.CurrentVersion, storeURL: StoreURL!)
}

private let StoreURL = NSURL.documentsURL.URLByAppendingPathComponent("weather.sqlite")
