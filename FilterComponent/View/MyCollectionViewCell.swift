//
//  MyCollectionViewCell.swift
//  FilterComponent
//
//  Created by Sumit Makkar on 19/05/20.
//  Copyright © 2020 Sumit Makkar. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleLabelWidthConstraint: NSLayoutConstraint!
        
    func setupCell(WithData data: String, andWidth cellWidth: CGFloat = 120)
    {
        titleLbl.text = data
        titleLabelWidthConstraint.constant = cellWidth
    }
}
