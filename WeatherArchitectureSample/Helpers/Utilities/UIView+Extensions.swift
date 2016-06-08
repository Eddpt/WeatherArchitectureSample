//
//  UIView+Extensions.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 10/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import UIKit

extension UIView {
  static var nibName: String {
    return className(fromModuleClassName: self)!
  }
}
