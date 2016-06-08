//
//  ManagedObjectContextSettable.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 09/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

protocol ManagedObjectContextSettable: class {
  var managedObjectContext: NSManagedObjectContext! { get set }
}
