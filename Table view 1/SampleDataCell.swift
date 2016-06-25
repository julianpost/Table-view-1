//
//  SampleDataCell.swift
//  Table view 1
//
//  Created by Julian Post on 6/23/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit

class SampleDataCell: UITableViewCell {
    
    @IBOutlet weak var wetWt: UILabel!
 
    
    var sample: TargetWeightData! {
        didSet {
            wetWt.text = String(sample.wetWt)
      
        }
    }
    
   
    
    
}

