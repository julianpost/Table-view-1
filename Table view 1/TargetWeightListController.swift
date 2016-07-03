//
//  TargetWeightListController.swift
//  Table view 1
//
//  Created by Julian Post on 6/23/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit
import CoreData

class TargetWeightListController: UITableViewController, MyTableVCViewControllerDelegate, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext: NSManagedObjectContext!

    
    
    var samples:[TargetWeightData] = samplesData
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Sample")
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        samples = samplesData
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        
        // Seed Persistent Store
        seedPersistentStore()
    }
    
    func myVCDidFinish(controller: MyTableVCTableViewController, sample: TargetWeightData) {
        
        samplesData.append(sample)
        samples = samplesData
        testLabel.text = "changed"
        
        controller.navigationController?.popViewControllerAnimated(true)
        
        
    
      /*  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
        let managedContext = appDelegate.managedObjectContext
    
        let entity = NSEntityDescription.entityForName("ListEntity", inManagedObjectContext: managedContext)
    
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        item.setValue(itemToSave, forKey: "item")
        
            do {
        
            try.managedContext.save()
            
            samplesData.append(sample)
            
        
                }
        
            catch {
                print("error")
                
                }
        
        
 */
    }
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            if segue.identifier == "MySegue" {
                if let navigationController = segue.destinationViewController as? UINavigationController {
                    if let viewController = navigationController.topViewController as? MyTableVCTableViewController {
                        viewController.managedObjectContext = managedObjectContext
                    }
                }
                
            } else if segue.identifier == "SegueUpdateViewController" {
                if let viewController = segue.destinationViewController as? UpdateViewController {
                    if let indexPath = tableView.indexPathForSelectedRow {
                        // Fetch Record
                        let record = fetchedResultsController.objectAtIndexPath(indexPath) as! Sample
                        
                        // Configure View Controller
                        viewController.record = record
                        viewController.managedObjectContext = managedObjectContext
                    }
                }
            }
        }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0

    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TargetDataCell", forIndexPath: indexPath) as! SampleDataCell
        
        // Configure Table View Cell
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: SampleDataCell, atIndexPath indexPath: NSIndexPath) {
        // Fetch Record
        let record = fetchedResultsController.objectAtIndexPath(indexPath)
        
        // Update Cell
        cell.sample = record as! Sample
    }
    
    
    
    // MARK: -
    // MARK: Table View Delegate Methods
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: -
    // MARK: Fetched Results Controller Delegate Methods
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch (type) {
        case .Insert:
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break;
        case .Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break;
        case .Update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! SampleDataCell
                configureCell(cell, atIndexPath: indexPath)
            }
            break;
        case .Move:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            }
            break;
        }
    }

    /*
 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("TargetDataCell", forIndexPath: indexPath)
                as! SampleDataCell
            
            let sample = samples[indexPath.row] as TargetWeightData
            cell.sample = sample
            return cell
    }
*/
    
   /* @IBAction func saveSample(segue: UIStoryboardSegue){
        print("Hello")
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

    @IBOutlet weak var testLabel: UILabel!
    
    
    
    // MARK: -
    // MARK: Helper Methods
    private func seedPersistentStore() {
        // Create Entity Description
        let entityDescription = NSEntityDescription.entityForName("Sample", inManagedObjectContext: managedObjectContext)
        
        for i in 0...2 {
            // Initialize Record
            let record = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: self.managedObjectContext)
            
            // Populate Record
            record.setValue(i * 3, forKey: "wetWt")
            record.setValue(NSDate(), forKey: "createdAt")
            record.setValue("Sample \(i + 1)", forKey: "name")
        }
        
        do {
            // Save Record
            try managedObjectContext?.save()
            
        } catch {
            let saveError = error as NSError
            print("\(saveError), \(saveError.userInfo)")
        }
    }

}