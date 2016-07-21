//
//  DataProvider.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 08/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation
import CoreData

protocol DataProvider {
  
  associatedtype DataObject
 
  func objectAtIndexPath(_ indexPath: IndexPath) -> DataObject
  
  func numberOfItemsInSection(_ section: Int) -> Int
}

protocol DataProviderDelegate: class {
  associatedtype DataObject: NSManagedObject
  func dataProviderDidUpdate(_ updates: [DataProviderUpdate<DataObject>]?)
}

enum DataProviderUpdate<DataObject> {
  case insert(IndexPath)
  case update(IndexPath, DataObject)
  case move(IndexPath, IndexPath)
  case delete(IndexPath)
}
