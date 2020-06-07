//
//  MyModel.swift
//  FilterComponent
//
//  Created by Sumit Makkar on 19/05/20.
//  Copyright © 2020 Sumit Makkar. All rights reserved.
//

import Foundation

let thresholdValue = 5

class MyModel {
    var filterName: String
    var childFilterArray: [ChildFilter]
    var isExpanded = false
    var isViewMoreEnabled = false
    
    init(filterName: String, childFilterArray: [ChildFilter])
    {
        self.filterName       = filterName
        self.childFilterArray = childFilterArray
    }
}

struct ChildFilter {
    var childFilterName: String
}


struct Nestedmodel {
    
}
