//
//  InnerMostTableViewCell.swift
//  FilterComponent
//
//  Created by Sumit Makkar on 09/06/20.
//  Copyright © 2020 Sumit Makkar. All rights reserved.
//

import UIKit

class InnerMostTableViewCell: UITableViewCell
{
    @IBOutlet weak var checkedImageView: UIImageView!
    @IBOutlet weak var subsubCatLabel: UILabel!
    
    func setupCell(with data: String?)
    {
        self.subsubCatLabel.text = data
    }
}
