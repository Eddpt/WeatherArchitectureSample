//
//  WeatherDataProvider.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 09/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

final class WeatherDataProvider<Delegate: DataProviderDelegate where Delegate.DataObject == WeatherRecord>: CoreDataDataProvider<WeatherRecord, Delegate> {
  
  typealias DataObject = WeatherRecord
  
  init(managedObjectContext: NSManagedObjectContext, delegate: Delegate) {
    let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    
    super.init(fetchedResultsController: frc, delegate: delegate)
  }
  
  //MARK: Private
  
  private var fetchRequest: NSFetchRequest<WeatherRecord> = {
    let fetchRequest = NSFetchRequest<WeatherRecord>(entityName: WeatherRecord.entityName)
    fetchRequest.sortDescriptors = [SortDescriptor(key: .recordDate, ascending: true)]
    
    return fetchRequest
  }()
}

private extension String {
#if swift(>=3)
  static let recordDate = NSStringFromSelector(#selector(getter: WeatherRecord.recordDate))
#else
  static let recordDate = "recordDate" // :( Hardcoded selectors are ugly
#endif
}
