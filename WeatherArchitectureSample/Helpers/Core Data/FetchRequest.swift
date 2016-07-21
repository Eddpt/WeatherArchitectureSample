//
//  FetchRequest.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 14/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import CoreData

public class FetchRequest<T: ManagedObject> {

    public class func fetchRequest(withPredicate predicate: Predicate, context: NSManagedObjectContext) -> NSFetchRequest<T> {
        let fetchRequest = NSFetchRequest<T>(entityName: T.entityName)
        fetchRequest.predicate = predicate

        return fetchRequest
    }
}
