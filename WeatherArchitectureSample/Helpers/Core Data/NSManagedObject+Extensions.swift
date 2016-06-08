//
//  NSManagedObject+Extensions.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 10/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

extension NSManagedObject {
  static var entityName: String {
    return className(fromModuleClassName: self)!
  }
}
