//
//  MyModel.swift
//  FilterComponent
//
//  Created by Sumit Makkar on 19/05/20.
//  Copyright © 2020 Sumit Makkar. All rights reserved.
//

import Foundation

struct MyModel {
    var filterName: String
    var childFilterArray: [ChildFilter]
    var isExpanded = false
    var isViewMoreEnabled = false
}

struct ChildFilter {
    var childFilterName: String
}
