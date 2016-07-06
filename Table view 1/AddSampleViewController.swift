//
//  MyTableVCTableViewController.swift
//  Table view 1
//
//  Created by Julian Post on 6/21/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit
import CoreData



class AddSampleViewController: UITableViewController {
    
   // var managedObjectContext: NSManagedObjectContext!
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
 
    
    var targetWeightData: TargetWeightData = TargetWeightData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    @IBAction func saveSample(sender: UIBarButtonItem) {
        
        
        
        let name = sampleNameField.text
        let dryWt = Double(dryField.text ?? "0") ?? 0
        let emptyBag = Double(emptyBagField.text ?? "0") ?? 0
        let fullBag = Double(fullBagField.text ?? "0") ?? 0
        let dryMatter = Double(moistureLbl.text ?? "0") ?? 0
        let targetMoisture = Double(targetMoistureField.text ?? "0") ?? 0
        let targetWt = Double(targetWtLbl.text ?? "0") ?? 0
        let wetWt = Double(wetField.text ?? "0") ?? 0

        if let isEmpty = name?.isEmpty where isEmpty == false {
            // Create Entity
            let entity = NSEntityDescription.entityForName("Sample", inManagedObjectContext: self.managedObjectContext)

            // Initialize Record
            let record = Sample(entity: entity!, insertIntoManagedObjectContext: self.managedObjectContext)
            
            // Populate Record
            
            if let sampleName = name {
                record.name = sampleName
            }
            
            record.dryWt = dryWt
            record.emptyBag = emptyBag
            record.fullBag = fullBag
            record.dryMatter = dryMatter
            record.targetMoisture = targetMoisture
            record.targetWt = targetWt
            record.wetWt = wetWt
            record.createdAt = NSDate()
            
            

            do {
                // Save Record
                try record.managedObjectContext?.save()
                
                // Dismiss View Controller
               /* dismissViewControllerAnimated(true, completion: nil) */
                navigationController?.popViewControllerAnimated(true)
                
          
                }
            
            catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
                // Show Alert View
                showAlertWithTitle("Warning", message: "Your to-do could not be saved.", cancelButtonTitle: "OK")
            }
            
            
        }

        /*
        if let isEmpty = name?.isEmpty where isEmpty == false {
            // Update Record
            record.setValue(name, forKey: "name")
            
            do {
                // Save Record
                try record.managedObjectContext?.save()
                
                // Dismiss View Controller
                navigationController?.popViewControllerAnimated(true)
                
            } catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
                // Show Alert View
                showAlertWithTitle("Warning", message: "Your to-do could not be saved.", cancelButtonTitle: "OK")
            }
            
        } else {
            // Show Alert View
            showAlertWithTitle("Warning", message: "Your to-do needs a name.", cancelButtonTitle: "OK")
        }
         */
        
        
        else {
            showAlertWithTitle("Please enter a sample name.", message: "", cancelButtonTitle: "OK")
            
        }
   
     
    }
    
    
    
    
    // MARK: -
    // MARK: Helper Methods
    private func showAlertWithTitle(title: String, message: String, cancelButtonTitle: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // Configure Alert Controller
        alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .Default, handler: nil))
        
        // Present Alert Controller
        presentViewController(alertController, animated: true, completion: nil)
    }
 
    
    
    

    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var sampleNameField: UITextField!
    
    @IBOutlet weak var wetField: UITextField!
    
    @IBOutlet weak var dryField: UITextField!
    
    @IBOutlet weak var moistureLbl: UILabel!
    
    @IBOutlet weak var targetMoistureField: UITextField!
    
    @IBOutlet weak var emptyBagField: UITextField!
    
    @IBOutlet weak var fullBagField: UITextField!
    
    @IBOutlet weak var targetWtLbl: UILabel!
    
    
    @IBAction func updateOnFieldChange(sender: UITextField) {
        updateCalculations()
    }
    
    func updateCalculations() {
        let wetWt:Double = Double(wetField.text ?? "0") ?? 0
        let dryWt:Double = Double(dryField.text ?? "0") ?? 0
        let dryMatter = Double(round(10 * ((dryWt / wetWt) * 100))/10)
        
        moistureLbl.text = String(dryMatter) + "%"
        
        let emptyBag: Double = Double(emptyBagField.text ?? "0") ?? 0
        let fullBag: Double = Double(fullBagField.text ?? "0") ?? 0
        let targetMoisture: Double = Double(targetMoistureField.text ?? "0") ?? 0
        let targetWt = (fullBag - emptyBag) * ((dryMatter)/(100 - targetMoisture)) + emptyBag
        let targetWtRounded = Double(round(10 * targetWt)/10)
        
        
        if (targetWtRounded < 0) && (fullBag != 0) {
            targetWtLbl.text = "sure?"
        }
        else if targetWtRounded <= 0 {
            targetWtLbl.text = ""
        }
            
        else {
            targetWtLbl.text = String(targetWtRounded)
        }
       /*
        targetWeightData.sampleName = sampleNameField.text
        targetWeightData.wetWt = Double(wetField.text ?? "0")
        targetWeightData.dryWt = Double(dryField.text ?? "0")
        targetWeightData.dryMatter = Double(moistureLbl.text ?? "0")
        targetWeightData.targetMoisture = Double(targetMoistureField.text ?? "0")
        targetWeightData.emptyBag = Double(emptyBagField.text ?? "0")
        targetWeightData.fullBag = Double(fullBagField.text ?? "0")
        targetWeightData.targetWt = Double(targetWtLbl.text ?? "0")
        */
    }

}
