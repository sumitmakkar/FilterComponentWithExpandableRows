//
//  MyModel.swift
//  FilterComponent
//
//  Created by Sumit Makkar on 19/05/20.
//  Copyright © 2020 Sumit Makkar. All rights reserved.
//

import Foundation

enum CellType
{
    case cellTypeOne
    case cellTypeTwo
}

let thresholdValue = 3

class MyModel {
    var filterName: String
    var childFilterArray: [ChildFilter]
    var isExpanded = false
    var isViewMoreEnabled = false
    var cellType: CellType = .cellTypeOne
    init(filterName: String, childFilterArray: [ChildFilter], cType: CellType = .cellTypeOne)
    {
        self.filterName       = filterName
        self.childFilterArray = childFilterArray
        self.cellType         = cType
    }
}

class ChildFilter {
    var childFilterName: String
    var subchildArray: [ChildFilter]? = nil
    var isExpanded = false
    
    init(childFilterName: String, subchildArray: [ChildFilter]? = nil)
    {
        self.childFilterName = childFilterName
        self.subchildArray   = subchildArray
    }
}
