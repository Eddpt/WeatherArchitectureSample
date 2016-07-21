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
  
  private let fetchedResultsController: NSFetchedResultsController<T>
  private weak var delegate: Delegate?
  private var updates: [DataProviderUpdate<CoreDataObject>] = []
  
  //MARK: Initializer
  
  init(fetchedResultsController: NSFetchedResultsController<T>, delegate: Delegate) {
    self.fetchedResultsController = fetchedResultsController
    self.delegate = delegate
    
    super.init()
    
    self.fetchedResultsController.delegate = self
    performFetch()
  }
  
  //MARK:
  
  func reconfigureFetchRequest(_ block: @noescape (NSFetchRequest<T>) -> ()) {
    NSFetchedResultsController<T>.deleteCache(withName: fetchedResultsController.cacheName)
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
  
  func objectAtIndexPath(_ indexPath: IndexPath) -> CoreDataObject {
    return fetchedResultsController.object(at: indexPath)    
  }
  
  func numberOfItemsInSection(_ section: Int) -> Int {
    return fetchedResultsController.sections?[section].numberOfObjects ?? 0
  }
  
  // MARK: NSFetchedResultsControllerDelegate
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    updates = []
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: AnyObject, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      guard let indexPath = newIndexPath else { fatalError("Index path should be not nil") }
      updates.append(.insert(indexPath))
    case .update:
      guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
      let object = objectAtIndexPath(indexPath)
      updates.append(.update(indexPath, object))
    case .move:
      guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
      guard let newIndexPath = newIndexPath else { fatalError("New index path should be not nil") }
      updates.append(.move(indexPath, newIndexPath))
    case .delete:
      guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
      updates.append(.delete(indexPath))
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    delegate?.dataProviderDidUpdate(updates)
  }
}
