//
//  CoreDataDataProvider.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 09/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

class CoreDataDataProvider<T: NSManagedObject, Delegate: DataProviderDelegate where T == Delegate.DataObject>: NSObject, NSFetchedResultsControllerDelegate, DataProvider {
  
  //MARK: Private
  
  private let fetchedResultsController: NSFetchedResultsController
  private weak var delegate: Delegate?
  private var updates: [DataProviderUpdate<CoreDataObject>] = []
  
  //MARK: Initializer
  
  init(fetchedResultsController: NSFetchedResultsController, delegate: Delegate) {
    self.fetchedResultsController = fetchedResultsController
    self.delegate = delegate
    
    super.init()
    
    self.fetchedResultsController.delegate = self
    performFetch()
  }
  
  //MARK:
  
  func reconfigureFetchRequest(@noescape block: NSFetchRequest -> ()) {
    NSFetchedResultsController.deleteCacheWithName(fetchedResultsController.cacheName)
    block(fetchedResultsController.fetchRequest)
    
    performFetch()
  }
  
  //MARK: Private
  
  private func performFetch() {
    do {
      try fetchedResultsController.performFetch()
    } catch {
      fatalError("fetch request failed")
    }
    
    delegate?.dataProviderDidUpdate(nil)
  }
  
  //MARK: DataProvider
  
  typealias CoreDataObject = T
  
  func objectAtIndexPath(indexPath: NSIndexPath) -> CoreDataObject {
    guard let fetchedObject = fetchedResultsController.objectAtIndexPath(indexPath) as? CoreDataObject else { fatalError("Unexpected object at \(indexPath)") }
    
    return fetchedObject
  }
  
  func numberOfItemsInSection(section: Int) -> Int {
    return fetchedResultsController.sections?[section].numberOfObjects ?? 0
  }
  
  // MARK: NSFetchedResultsControllerDelegate
  
  func controllerWillChangeContent(controller: NSFetchedResultsController) {
    updates = []
  }
  
  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    switch type {
    case .Insert:
      guard let indexPath = newIndexPath else { fatalError("Index path should be not nil") }
      updates.append(.Insert(indexPath))
    case .Update:
      guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
      let object = objectAtIndexPath(indexPath)
      updates.append(.Update(indexPath, object))
    case .Move:
      guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
      guard let newIndexPath = newIndexPath else { fatalError("New index path should be not nil") }
      updates.append(.Move(indexPath, newIndexPath))
    case .Delete:
      guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
      updates.append(.Delete(indexPath))
    }
  }
  
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
    delegate?.dataProviderDidUpdate(updates)
  }
}