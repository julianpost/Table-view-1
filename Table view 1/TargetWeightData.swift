//
//  TargetWeight.swift
//  Table view 1
//
//  Created by Julian Post on 6/23/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit


struct TargetWeightData {
    var wetWt: Double?
    var dryWt: Double?
    var moistureContent: Double?
    var targetMoisture: Double?
    var emptyBag: Double?
    var fullBag: Double?
    var targetWt: Double?
    
    init(wetWt: Double? = nil, dryWt: Double? = nil, moistureContent: Double? = nil, targetMoisture: Double? = nil, emptyBag: Double? = nil, fullBag: Double? = nil, targetWt: Double? = nil) {
        self.wetWt = wetWt
        self.dryWt = dryWt
        self.moistureContent = moistureContent
        self.targetMoisture = targetMoisture
        self.emptyBag = emptyBag
        self.fullBag = fullBag
        self.targetWt = targetWt
    }
}