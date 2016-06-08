//
//  WeatherTableViewDataCoordinator.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 08/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import UIKit

final class WeatherTableViewDataCoordinator<Delegate: DataProviderDelegate where Delegate.DataObject == WeatherRecord> : GenericTableViewDataCoordinator<WeatherDataProvider<Delegate>, WeatherTableViewCell> {
  
  //MARK: Initializer

  init(tableView: UITableView, weatherDataProvider: WeatherDataProvider<Delegate>) {
    let weatherCellNib = UINib(nibName: WeatherTableViewCell.nibName, bundle: nil)
    tableView.registerNib(weatherCellNib, forCellReuseIdentifier: WeatherTableViewCell.reuseIdentifier)
    
    super.init(tableView: tableView, dataProvider: weatherDataProvider)
  }
}
