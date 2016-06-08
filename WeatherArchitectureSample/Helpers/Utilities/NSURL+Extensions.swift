//
//  NSURL+Extensions.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 09/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

extension NSURL {
  static var documentsURL: NSURL {
    return try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
  }
}