//
//  ConfigurableCell.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 08/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

public protocol ConfigurableCell: class {
  
  associatedtype DataObject
  
  func configure(forObject object: DataObject)
  
  static var reuseIdentifier: String { get }
}

extension ConfigurableCell {
  static var reuseIdentifier: String {
    return className(fromModuleClassName: self)!
  }
}
