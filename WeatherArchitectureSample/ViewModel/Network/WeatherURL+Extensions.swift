//
//  WeatherURL+Extensions.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 14/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

extension NSURL {
  func addComponent(withName name: String, value: String) -> NSURL? {
    let urlComponents = NSURLComponents(URL: self, resolvingAgainstBaseURL: true)
    
    var queryItems = [NSURLQueryItem(name: name, value: value)]
    if let originalQueryItem = urlComponents?.queryItems  {
      queryItems.insertContentsOf(originalQueryItem, at: 0)
    }
    
    urlComponents?.queryItems = queryItems
    
    return urlComponents?.URL
  }
}