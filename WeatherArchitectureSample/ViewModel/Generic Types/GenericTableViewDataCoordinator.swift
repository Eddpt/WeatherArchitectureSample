//
//  GenericTableViewDataCoordinator.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 08/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import UIKit

class GenericTableViewDataCoordinator<DataProviderType: DataProvider, CellType: UITableViewCell where CellType: ConfigurableCell, CellType.DataObject == DataProviderType.DataObject> : NSObject, UITableViewDataSource {

  //MARK: Private

  private let tableView: UITableView
  private let dataProvider: DataProviderType
  
  //MARK: Initializer

  init(tableView: UITableView, dataProvider: DataProviderType) {
    self.tableView = tableView
    self.dataProvider = dataProvider
    super.init()
    
    tableView.dataSource = self
  }
  
  /**
   Method responsible for processing a list of updates and performing the desired changes in the tableview
   
   - parameter updates: Optional list of DataProviderUpdates (possible values: Insert/Update/Move/Delete)
   */
  func processUpdates(updates: [DataProviderUpdate<DataProviderType.DataObject>]?) {
    guard let updates = updates else { return tableView.reloadData() }
    
    tableView.beginUpdates()
    for update in updates {
      switch update {
      case .Insert(let indexPath):
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
      case .Update(let indexPath, let object):
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? CellType else { break }
        cell.configure(forObject: object)
      case .Move(let indexPath, let newIndexPath):
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
      case .Delete(let indexPath):
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
      }
    }
    tableView.endUpdates()
  }

  
  //MARK: UITableViewDataSource
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCellWithIdentifier(CellType.reuseIdentifier) as? CellType else {
      fatalError("Could not dequeue cell of type: \(CellType.self) with identifier: \(CellType.reuseIdentifier)")
    }
    
    let object = dataProvider.objectAtIndexPath(indexPath)
    cell.configure(forObject: object)
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataProvider.numberOfItemsInSection(section)
  }
}