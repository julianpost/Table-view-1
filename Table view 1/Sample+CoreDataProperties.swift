//
//  Sample+CoreDataProperties.swift
//  Table view 1
//
//  Created by Julian Post on 7/3/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Sample {

    @NSManaged var createdAt: NSTimeInterval
    @NSManaged var dryWt: Double
    @NSManaged var emptyBag: Double
    @NSManaged var fullBag: Double
    @NSManaged var moistureContent: Double
    @NSManaged var name: String
    @NSManaged var targetMoisture: Double
    @NSManaged var targetWt: Double
    @NSManaged var wetWt: Double

}
