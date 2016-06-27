//
//  TargetWeightListController.swift
//  Table view 1
//
//  Created by Julian Post on 6/23/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit

class TargetWeightListController: UITableViewController, MyTableVCViewControllerDelegate {
    
    var samples:[TargetWeightData] = samplesData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        samples = samplesData
    }
    
    func myVCDidFinish(controller: MyTableVCTableViewController, sample: TargetWeightData) {
        
        samplesData.append(sample)
        samples = samplesData
        testLabel.text = "changed"
        
        controller.navigationController?.popViewControllerAnimated(true)
        }
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            if segue.identifier == "mySegue" {
                let vc = segue.destinationViewController as! MyTableVCTableViewController
                //vc.colorString = colorLabel.text!
                vc.delegate = self
            }
        }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return samples.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("TargetDataCell", forIndexPath: indexPath)
                as! SampleDataCell
            
            let sample = samples[indexPath.row] as TargetWeightData
            cell.sample = sample
            return cell
    }

    
   /* @IBAction func saveSample(segue: UIStoryboardSegue){
        print("Hello")
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

    @IBOutlet weak var testLabel: UILabel!

}