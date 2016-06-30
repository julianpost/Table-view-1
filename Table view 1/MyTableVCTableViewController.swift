//
//  MyTableVCTableViewController.swift
//  Table view 1
//
//  Created by Julian Post on 6/21/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit
import CoreData

protocol MyTableVCViewControllerDelegate {
    func myVCDidFinish(controller: MyTableVCTableViewController, sample: TargetWeightData)
}

class MyTableVCTableViewController: UITableViewController {
    
   let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var delegate:MyTableVCViewControllerDelegate? = nil
    
    var targetWeightData: TargetWeightData = TargetWeightData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleNameField.text = targetWeightData.sampleName ?? ""
        wetField.text = String(targetWeightData.wetWt ?? 0)
        dryField.text = String(targetWeightData.dryWt ?? 0)
        moistureLbl.text = String(targetWeightData.moistureContent ?? 0) + "%"
        
        emptyBagField.text = String(targetWeightData.emptyBag ?? 0)
        fullBagField.text = String(targetWeightData.fullBag ?? 0)
        targetMoistureField.text = String(targetWeightData.targetMoisture ?? 0)
        targetWtLbl.text = String(targetWeightData.targetWt ?? 0)
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    @IBAction func saveSample(sender: UIBarButtonItem) {
        
      //  samplesData.append(targetWeightData)
        
        let entityDescription =
            NSEntityDescription.entityForName("ListEntity",
                                              inManagedObjectContext: managedObjectContext!)
        
        let sample = ListEntity(entity: entityDescription!,
                               insertIntoManagedObjectContext: managedObjectContext)
        
        
        ListEntity.sampleName = sampleNameField.text
        ListEntity.wetWt = Double(wetField.text ?? "0")
        ListEntity.dryWt = Double(dryField.text ?? "0")
        ListEntity.moistureContent = Double(moistureLbl.text ?? "0")
        ListEntity.targetMoisture = Double(targetMoistureField.text ?? "0")
        ListEntity.emptyBag = Double(emptyBagField.text ?? "0")
        ListEntity.fullBag = Double(fullBagField.text ?? "0")
        ListEntity.targetWt = Double(targetWtLbl.text ?? "0")
        
        var error: NSError?
        
        managedObjectContext?.save(&error)
        
        if let err = error {
            status.text = err.localizedFailureReason
        } else {
            sampleNameField.text = nil
            wetField.text = nil
            dryField.text = nil
            moistureLbl.text = nil
            
            emptyBagField.text = nil
            fullBagField.text = nil
            targetMoistureField.text = nil
            targetWtLbl.text = nil
        }
        
        if (delegate != nil) {
            delegate!.myVCDidFinish(self, sample: targetWeightData)
        }
     
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
        
        targetWeightData.sampleName = sampleNameField.text
        targetWeightData.wetWt = Double(wetField.text ?? "0")
        targetWeightData.dryWt = Double(dryField.text ?? "0")
        targetWeightData.moistureContent = Double(moistureLbl.text ?? "0")
        targetWeightData.targetMoisture = Double(targetMoistureField.text ?? "0")
        targetWeightData.emptyBag = Double(emptyBagField.text ?? "0")
        targetWeightData.fullBag = Double(fullBagField.text ?? "0")
        targetWeightData.targetWt = Double(targetWtLbl.text ?? "0")
        
    }

}
