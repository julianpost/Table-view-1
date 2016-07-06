//
//  TargetWeightListController.swift
//  Table view 1
//
//  Created by Julian Post on 6/23/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit
import CoreData

class SampleListViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var managedObjectContext: NSManagedObjectContext!

    var resultSearchController = UISearchController(searchResultsController: nil)
    
  //  var samples:[TargetWeightData] = samplesData
    
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
  //      samples = samplesData
        
       
        
        // Seed Persistent Store
       // seedPersistentStore()
        
        // initialize search controller after the core data
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        // places the built-in searchbar into the header of the table
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        // makes the searchbar stay in the current screen and not spill into the next screen
        definesPresentationContext = true
        
     // hides the search bar when the view loads
        tableView.setContentOffset(CGPoint(x: 0, y: resultSearchController.searchBar.frame.size.height), animated: false)
                
    
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        
        }
    
    
    // update the contents of a fetch results controller
    func fetch(frcToFetch: NSFetchedResultsController) {
        
        do {
            try frcToFetch.performFetch()
        } catch {
            return
        }
    }
    
    func fetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "Sample")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    // updates the table view with the search results as user is typing...
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        // process the search string, remove leading and trailing spaces
        let searchText = searchController.searchBar.text!
        let trimmedSearchString = searchText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // if search string is not blank
        if !trimmedSearchString.isEmpty {
            
            // form the search format
            let predicate = NSPredicate(format: "(name contains [cd] %@)", trimmedSearchString)
            
            // add the search filter
            fetchedResultsController.fetchRequest.predicate = predicate
        }
        else {
            
            // reset to all samples if search string is blank
            fetchedResultsController = getFetchedResultsController()
        }
        
        // reload the frc
        fetch(fetchedResultsController)
        
        // refresh the table view
        self.tableView.reloadData()
    }

   /* func myVCDidFinish(controller: AddSampleViewController, sample: TargetWeightData) {
        
        samplesData.append(sample)
        samples = samplesData
        testLabel.text = "changed"
        
        controller.navigationController?.popViewControllerAnimated(true)
        
        */
    
    
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
        
        
 
    } 
     
     */
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            if segue.identifier == "MySegue" {
                
                    
              if let viewController = segue.destinationViewController as? AddSampleViewController {
                    
                        viewController.managedObjectContext = managedObjectContext
                }
                
                
            }
            
            else if segue.identifier == "SegueUpdateViewController" {
                if let viewController = segue.destinationViewController as? UpdateSampleViewController {
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
        let cell = tableView.dequeueReusableCellWithIdentifier("SampleDataCell", forIndexPath: indexPath) as! SampleDataCell
        
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

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            // Fetch Record
            let record = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
            
            // Delete Record
            managedObjectContext.deleteObject(record)
            
            // reload the frc
            fetch(fetchedResultsController)
            
            // refresh the table view
            self.tableView.reloadData()
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