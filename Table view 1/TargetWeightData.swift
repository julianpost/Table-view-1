//
//  TargetWeight.swift
//  Table view 1
//
//  Created by Julian Post on 6/23/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit


struct TargetWeightData {
    var sampleName: String?
    var wetWt: Double?
    var dryWt: Double?
    var moistureContent: Double?
    var targetMoisture: Double?
    var emptyBag: Double?
    var fullBag: Double?
    var targetWt: Double?
    
    init(sampleName: String? = nil, wetWt: Double? = nil, dryWt: Double? = nil, moistureContent: Double? = nil, targetMoisture: Double? = nil, emptyBag: Double? = nil, fullBag: Double? = nil, targetWt: Double? = nil) {
        self.sampleName = sampleName
        self.wetWt = wetWt
        self.dryWt = dryWt
        self.moistureContent = moistureContent
        self.targetMoisture = targetMoisture
        self.emptyBag = emptyBag
        self.fullBag = fullBag
        self.targetWt = targetWt
    }
}