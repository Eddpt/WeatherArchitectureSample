//
//  WeatherViewController.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 08/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import UIKit
import CoreData

final class WeatherViewController: UIViewController, ManagedObjectContextSettable {
  
  //MARK: ManagedObjectContextSettable
  
  var managedObjectContext: NSManagedObjectContext!
  
  //MARK: Private Properties
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var refreshButton: UIBarButtonItem!
  
  private var tableViewDataCoordinator: WeatherTableViewDataCoordinator<WeatherViewController>!
  private let weatherAPIClient = WeatherAPIClient()
  private var requestTask: NSURLSessionDataTask?
  
  //MARK: Lifecycle
  
  deinit {
    requestTask?.cancel()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let weatherDataProvider = WeatherDataProvider(managedObjectContext: managedObjectContext, delegate: self)
    tableViewDataCoordinator = WeatherTableViewDataCoordinator(tableView: tableView, weatherDataProvider: weatherDataProvider)
    
    refreshWeather()
  }
  
  //MARK: Actions
  
  @objc @IBAction private func didTapRefresh(sender: AnyObject) {
    refreshWeather()
  }
  
  //MARK: Private Methods

  private func refreshWeather() {
    changeRefreshState(toRefreshingState: true)
    
    requestTask = weatherAPIClient.fetchWeatherForecast(forCity: "Lisbon", weatherPersistence: WeatherPersistence(managedObjectContext: managedObjectContext))
  }
  
  private func changeRefreshState(toRefreshingState state: Bool) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = state
    refreshButton.enabled = !state
  }
  
}

extension WeatherViewController: DataProviderDelegate {
  typealias DataObject = WeatherRecord
  
  func dataProviderDidUpdate(updates: [DataProviderUpdate<WeatherRecord>]?) {
    guard let updates = updates else {
      return
    }
    
    changeRefreshState(toRefreshingState: false)
    
    tableViewDataCoordinator.processUpdates(updates)
  }
}