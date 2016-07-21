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
  func processUpdates(_ updates: [DataProviderUpdate<DataProviderType.DataObject>]?) {
    guard let updates = updates else { return tableView.reloadData() }
    
    tableView.beginUpdates()
    for update in updates {
      switch update {
      case .insert(let indexPath):
        tableView.insertRows(at: [indexPath], with: .fade)
      case .update(let indexPath, let object):
        guard let cell = tableView.cellForRow(at: indexPath) as? CellType else { break }
        cell.configure(forObject: object)
      case .move(let indexPath, let newIndexPath):
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.insertRows(at: [newIndexPath], with: .fade)
      case .delete(let indexPath):
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
    tableView.endUpdates()
  }

  
  //MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseIdentifier) as? CellType else {
      fatalError("Could not dequeue cell of type: \(CellType.self) with identifier: \(CellType.reuseIdentifier)")
    }
    
    let object = dataProvider.objectAtIndexPath(indexPath)
    cell.configure(forObject: object)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataProvider.numberOfItemsInSection(section)
  }
}
