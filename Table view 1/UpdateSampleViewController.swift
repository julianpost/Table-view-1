//
//  MyTableVCTableViewController.swift
//  Table view 1
//
//  Created by Julian Post on 6/21/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit
import CoreData



class UpdateSampleViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var name: NSManagedObject!
    //var dryWt: NSManagedObject!
    var record: Sample!
    
  
    
//    var targetWeightData: TargetWeightData = TargetWeightData()
    
    
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
        let moistureContent = Double(round(10 * ((1 - (dryWt / wetWt)) * 100))/10)
        
        moistureLbl.text = String(moistureContent) + "%"
        
        let emptyBag: Double = Double(emptyBagField.text ?? "0") ?? 0
        let fullBag: Double = Double(fullBagField.text ?? "0") ?? 0
        let targetMoisture: Double = Double(targetMoistureField.text ?? "0") ?? 0
        let targetWt = (fullBag - emptyBag) * ((100 - moistureContent)/(100-targetMoisture)) + emptyBag
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
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           
        
       
    sampleNameField.text = record.name
    dryField.text = String(record.dryWt)
    emptyBagField.text = String(record.emptyBag)
    fullBagField.text = String(record.fullBag)
    targetMoistureField.text = String(record.targetMoisture)
    wetField.text = String(record.wetWt)
        
    updateCalculations()
                
            
        }
        
        
        


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    @IBAction func saveSample(sender: UIBarButtonItem) {
        
      //  samplesData.append(targetWeightData)
        
        let name = sampleNameField.text
        let dryWt = Double(dryField.text ?? "0") ?? 0
        let emptyBag = Double(emptyBagField.text ?? "0") ?? 0
        let fullBag = Double(fullBagField.text ?? "0") ?? 0
        let moistureContent = Double(moistureLbl.text ?? "0") ?? 0
        let targetMoisture = Double(targetMoistureField.text ?? "0") ?? 0
        let targetWt = Double(targetWtLbl.text ?? "0") ?? 0
        let wetWt = Double(wetField.text ?? "0") ?? 0

        if let isEmpty = name?.isEmpty where isEmpty == false {
            // Update Record
            record.setValue(name, forKey: "name")
            record.setValue(dryWt, forKey: "dryWt")
            record.setValue(emptyBag, forKey: "emptyBag")
            record.setValue(fullBag, forKey: "fullBag")
            record.setValue(moistureContent, forKey: "moistureContent")
            record.setValue(targetMoisture, forKey: "targetMoisture")
            record.setValue(targetWt, forKey: "targetWt")
            record.setValue(wetWt, forKey: "wetWt")
            
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
        
        
        
   //     if (delegate != nil) {
    //        delegate!.myVCDidFinish(self, sample: targetWeightData)
    //    }
     
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
 
    
    
    

   

}
