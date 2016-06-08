//
//  JSONMappable.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 09/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

protocol JSONMappable {
  func updateWithJSONDictionary(JSONDictionary: JSONDictionary) throws -> Self
}

extension JSONMappable {
  func updateWithJSONArray(jsonArray: [JSONDictionary]) throws -> [Self] {
    var result: [Self] = []
    
    for jsonDictionary in jsonArray {
      result.append(try self.updateWithJSONDictionary(jsonDictionary))
    }
    
    return result
  }
}