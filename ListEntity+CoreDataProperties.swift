//
//  ListEntity+CoreDataProperties.swift
//  Table view 1
//
//  Created by Julian Post on 6/29/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ListEntity {

    @NSManaged var dryWt: NSNumber?
    @NSManaged var sampleName: String?
    @NSManaged var wetWt: NSNumber?
    @NSManaged var moistureContent: NSNumber?
    @NSManaged var targetMoisture: NSNumber?
    @NSManaged var emptyBag: NSNumber?
    @NSManaged var fullBag: NSNumber?
    @NSManaged var targetWt: NSNumber?

}
