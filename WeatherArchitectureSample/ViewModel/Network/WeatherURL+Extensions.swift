//
//  WeatherURL+Extensions.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 14/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

extension URL {
  func addComponent(withName name: String, value: String) -> URL? {
    var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)
    
    var queryItems = [URLQueryItem(name: name, value: value)]
    if let originalQueryItem = urlComponents?.queryItems  {
      queryItems.insert(contentsOf: originalQueryItem, at: 0)
    }
    
    urlComponents?.queryItems = queryItems
    
    return urlComponents?.url
  }
}
