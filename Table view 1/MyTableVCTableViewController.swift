//
//  MyTableVCTableViewController.swift
//  Table view 1
//
//  Created by Julian Post on 6/21/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit

class MyTableVCTableViewController: UITableViewController {
    
    var targetWeightData: TargetWeightData = TargetWeightData(wetWt: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wetField.text = String(targetWeightData.wetWt ?? 0)
        dryField.text = String(targetWeightData.dryWt ?? 0)
        moistureLbl.text = String(targetWeightData.moistureContent ?? 0) + "%"
        
        emptyBagField.text = String(targetWeightData.emptyBag ?? 0)
        fullBagField.text = String(targetWeightData.fullBag ?? 0)
        targetMoistureField.text = String(targetWeightData.targetMoisture ?? 0)
        targetWtLbl.text = String(targetWeightData.targetWt ?? 0)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    




    


    
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
    
    
    
    
    @IBOutlet weak var moistureLbl: UILabel!
    
    @IBOutlet weak var targetWtLbl: UILabel!
    
    @IBOutlet weak var wetField: UITextField!
    
    @IBOutlet weak var dryField: UITextField!
    
    @IBOutlet weak var targetMoistureField: UITextField!
    
    @IBOutlet weak var emptyBagField: UITextField!
    
    @IBOutlet weak var fullBagField: UITextField!
    
    
    @IBAction func updateOnFieldChange(sender: UITextField) {
        updateCalculations()
    }

}
