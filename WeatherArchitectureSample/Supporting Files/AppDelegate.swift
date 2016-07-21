//
//  AppDelegate.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 08/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    configureMainObjectContext()
    
    // TEST CODE
    //loadWeatherRecords()
    
    return true
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    managedObjectContext.saveContext()
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    managedObjectContext.saveContext()
  }
  
  //MARK: Private
  
  private lazy var managedObjectContext: NSManagedObjectContext = {
    guard let context = createWeatherMainContext() else { fatalError("Could not create the Main Context") }
    return context
  }()

  private func configureMainObjectContext() {
    guard let vc = window?.rootViewController?.childViewControllers.first as? ManagedObjectContextSettable else { fatalError("Wrong view controller type") }
    vc.managedObjectContext = managedObjectContext
  }
  
//  TEST CODE
//  private func loadWeatherRecords() {
//    WeatherLoader.allWeatherRecords(managedObjectContext)
//  }
}

