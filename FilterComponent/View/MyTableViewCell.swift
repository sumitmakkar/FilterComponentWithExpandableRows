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
    
    func setupCell(withData data: MyModel)
    {
        self.dataSource             = data
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
        return dataSource.childFilterArray.count < 5 ? dataSource.childFilterArray.count : (dataSource.childFilterArray.count >= 5 && self.dataSource.isViewMoreEnabled) ? dataSource.childFilterArray.count : 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if (indexPath.row < 4 || (indexPath.row >= 4 && self.dataSource.isViewMoreEnabled))
        {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvc", for: indexPath) as? MyCollectionViewCell
            {
                cell.setupCell(WithData: dataSource.childFilterArray[indexPath.row].childFilterName)
                return cell
            }
        }
        else
        {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewmore", for: indexPath) as? ViewMoreCollectionViewCell
            {
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
            self.dataSource.isViewMoreEnabled = true
            collectionView.reloadData()
        }
    }
}
