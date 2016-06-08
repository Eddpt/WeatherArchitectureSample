//
//  JsonDataParser.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 14/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

class InvalidJSONDataError: ErrorType { }

final class JsonDataParser {
  class func parse(withData data: NSData) throws -> JSONDictionary {
    do {
      guard let resultData = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? JSONDictionary else {
        throw InvalidJSONDataError()
      }
      return resultData
    
    } catch {
      throw InvalidJSONDataError()
    }
  }
}
