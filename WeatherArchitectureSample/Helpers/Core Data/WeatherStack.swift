//
//  WeatherStack.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 09/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

public func createWeatherMainContext() -> NSManagedObjectContext? {
  return NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType, modelVersion: WeatherModelVersion.CurrentVersion, storeURL: StoreURL)
}

private let StoreURL = try! URL.documentsURL.appendingPathComponent("weather.sqlite")
