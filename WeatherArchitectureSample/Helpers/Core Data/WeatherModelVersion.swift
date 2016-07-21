//
//  WeatherModelVersion.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 09/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

enum WeatherModelVersion: String {
  case Version1 = "Weather"
}

extension WeatherModelVersion: ModelVersionType {
  static var AllVersions: [WeatherModelVersion] { return [.Version1] }
  static var CurrentVersion: WeatherModelVersion { return .Version1 }
  
  var name: String { return rawValue }
  var modelBundle: Bundle { return Bundle(for: WeatherRecord.self) }
  var modelDirectoryName: String { return "Weather.momd" }
}
