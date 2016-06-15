//
//  SequenceType+Extensions.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 09/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

extension SequenceType {
  
  func findFirstOccurence(@noescape block: Generator.Element -> Bool) -> Generator.Element? {
    for x in self where block(x) {
      return x
    }
    
    return nil
  }
}
