//
//  MyTableViewCell.swift
//  FilterComponent
//
//  Created by Sumit Makkar on 19/05/20.
//  Copyright © 2020 Sumit Makkar. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell
{
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    private var dataSource: MyModel!
    
    var reloadIndexPath: ((IndexPath?) -> Void)?
    var currentIndexPath: IndexPath?
    
    func setupCell(withData data: MyModel, andIndexPath indexPath: IndexPath)
    {
        self.dataSource             = data
        self.currentIndexPath       = indexPath
        lbl.text                    = data.filterName
        myCollectionView.dataSource = self
        myCollectionView.delegate   = self
        myCollectionView.reloadData()
    }
}

extension MyTableViewCell: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataSource.childFilterArray.count <= thresholdValue ? dataSource.childFilterArray.count : (dataSource.childFilterArray.count > thresholdValue && self.dataSource.isViewMoreEnabled) ? dataSource.childFilterArray.count + 1 : thresholdValue+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if (indexPath.row < thresholdValue || (self.dataSource.isViewMoreEnabled && indexPath.row < self.dataSource.childFilterArray.count))
        {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvc", for: indexPath) as? MyCollectionViewCell
            {
                /*let lastValue          = self.dataSource.childFilterArray.count > thresholdValue ? self.dataSource.isViewMoreEnabled ? self.dataSource.childFilterArray.count : thresholdValue - 1 : self.dataSource.childFilterArray.count*/
                var lastValue: Int
                var cellWidth: CGFloat = 120
                if min(thresholdValue, self.dataSource.childFilterArray.count) % 2 == 1
                {
                    lastValue = self.dataSource.isViewMoreEnabled ? self.dataSource.childFilterArray.count : thresholdValue - 1
                    cellWidth = indexPath.item == lastValue ? collectionView.frame.size.width - 32 : 120
                }
                cell.setupCell(WithData: dataSource.childFilterArray[indexPath.row].childFilterName, andWidth: cellWidth)
                return cell
            }
        }
        else
        {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewmore", for: indexPath) as? ViewMoreCollectionViewCell
            {
                cell.setupCell(with: self.dataSource.isViewMoreEnabled ? "Show Less" : "View More")
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension MyTableViewCell: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if let _ = collectionView.cellForItem(at: indexPath) as? ViewMoreCollectionViewCell
        {
            self.dataSource.isViewMoreEnabled = !self.dataSource.isViewMoreEnabled
            collectionView.reloadData()
            self.reloadIndexPath?(self.currentIndexPath)
        }
    }
}
