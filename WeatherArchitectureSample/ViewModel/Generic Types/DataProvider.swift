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
 
  func objectAtIndexPath(indexPath: NSIndexPath) -> DataObject
  
  func numberOfItemsInSection(section: Int) -> Int
}

protocol DataProviderDelegate: class {
  associatedtype DataObject: NSManagedObject
  func dataProviderDidUpdate(updates: [DataProviderUpdate<DataObject>]?)
}

enum DataProviderUpdate<DataObject> {
  case Insert(NSIndexPath)
  case Update(NSIndexPath, DataObject)
  case Move(NSIndexPath, NSIndexPath)
  case Delete(NSIndexPath)
}
