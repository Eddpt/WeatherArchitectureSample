//
//  AnyClassUtilities.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 10/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

public func className(fromModuleClassName anyClass: AnyClass) -> String? {
  let fullClassName = NSStringFromClass(object_getClass(anyClass))
  let nameComponents = fullClassName.components(separatedBy: ".")
  
  return nameComponents.last
}
