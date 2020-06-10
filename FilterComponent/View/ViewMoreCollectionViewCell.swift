//
//  ViewMoreCollectionViewCell.swift
//  FilterComponent
//
//  Created by Sumit Makkar on 20/05/20.
//  Copyright © 2020 Sumit Makkar. All rights reserved.
//

import UIKit

class ViewMoreCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var viewMoreButton: UILabel!
    
    func setupCell(with labelString: String = "View More")
    {
        self.viewMoreButton.text = labelString
    }
}
