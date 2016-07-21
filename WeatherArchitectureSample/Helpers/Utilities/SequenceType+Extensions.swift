//
//  SequenceType+Extensions.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 09/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

extension Sequence {
  
  func findFirstOccurence(_ block: @noescape (Iterator.Element) -> Bool) -> Iterator.Element? {
    for x in self where block(x) {
      return x
    }
    
    return nil
  }
}
