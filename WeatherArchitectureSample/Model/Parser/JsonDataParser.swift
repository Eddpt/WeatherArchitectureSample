//
//  JsonDataParser.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 14/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

class InvalidJSONDataError: ErrorProtocol { }

final class JsonDataParser {
  class func parse(withData data: Data) throws -> JSONDictionary {
    do {
      guard let resultData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSONDictionary else {
        throw InvalidJSONDataError()
      }
      return resultData
    
    } catch {
      throw InvalidJSONDataError()
    }
  }
}
