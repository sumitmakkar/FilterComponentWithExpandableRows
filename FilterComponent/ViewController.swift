//
//  ViewController.swift
//  FilterComponent
//
//  Created by Sumit Makkar on 19/05/20.
//  Copyright © 2020 Sumit Makkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var mytableView: UITableView!
    
    var dataSourceArray: [MyModel]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateModel()
        mytableView.dataSource = self
        mytableView.delegate   = self
    }
    
    private func updateModel()
    {
        self.dataSourceArray = [MyModel(filterName: "Category 1", childFilterArray: [ChildFilter(childFilterName: "Subcat 1"), ChildFilter(childFilterName: "Subcat 2"), ChildFilter(childFilterName: "Subcat 3"), ChildFilter(childFilterName: "Subcat 4")]),
                MyModel(filterName: "Category 2", childFilterArray: [ChildFilter(childFilterName: "Subcat 5"), ChildFilter(childFilterName: "Subcat 6"), ChildFilter(childFilterName: "Subcat 7"), ChildFilter(childFilterName: "Subcat 8"), ChildFilter(childFilterName: "Subcat 9"), ChildFilter(childFilterName: "Subcat 100"), ChildFilter(childFilterName: "Subcat 101"), ChildFilter(childFilterName: "Subcat 102")]),
                MyModel(filterName: "Category 3", childFilterArray: [ChildFilter(childFilterName: "Subcat 10"), ChildFilter(childFilterName: "Subcat 11"), ChildFilter(childFilterName: "Subcat 12"), ChildFilter(childFilterName: "Subcat 13")]),
                MyModel(filterName: "Category 4", childFilterArray: [ChildFilter(childFilterName: "Subcat 14"), ChildFilter(childFilterName: "Subcat 15"), ChildFilter(childFilterName: "Subcat 16")]),
                MyModel(filterName: "Category 5", childFilterArray: [ChildFilter(childFilterName: "Subcat 17"), ChildFilter(childFilterName: "Subcat 18"), ChildFilter(childFilterName: "Subcat 19"), ChildFilter(childFilterName: "Subcat 20"), ChildFilter(childFilterName: "Subcat 21"), ChildFilter(childFilterName: "Subcat 22")]),
                MyModel(filterName: "Category 6", childFilterArray: [ChildFilter(childFilterName: "Subcat 23"), ChildFilter(childFilterName: "Subcat 24"), ChildFilter(childFilterName: "Subcat 25"), ChildFilter(childFilterName: "Subcat 26"), ChildFilter(childFilterName: "Subcat 27"), ChildFilter(childFilterName: "Subcat 28")])
        ]
    }
}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tvc", for: indexPath) as? MyTableViewCell
        {
            cell.setupCell(withData: self.dataSourceArray[indexPath.row], andIndexPath: indexPath)
            cell.reloadIndexPath = { [weak self] (currIndexPath) in
                guard let weakSelf = self, let cIdxPath = currIndexPath else { return }
                weakSelf.mytableView.reloadRows(at: [cIdxPath], with: UITableView.RowAnimation.automatic)
            }
            cell.layoutIfNeeded()
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.dataSourceArray[indexPath.row].isExpanded ? self.getHeightOfExpandedCell(atIndexPath: indexPath) : 78.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.dataSourceArray[indexPath.row].isExpanded = !(self.dataSourceArray[indexPath.row].isExpanded)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    private func getHeightOfExpandedCell(atIndexPath indexPath: IndexPath) -> CGFloat
    {
        let padding      : CGFloat = 10.0
        let filterHeight : CGFloat = 24.0
        if self.dataSourceArray[indexPath.row].childFilterArray.count > thresholdValue
        {
            return self.dataSourceArray[indexPath.row].isViewMoreEnabled ? (CGFloat((self.dataSourceArray[indexPath.row].childFilterArray.count/2) + (self.dataSourceArray[indexPath.section].childFilterArray.count%2) + 1) * (filterHeight + padding) + 78.5) : (CGFloat((thresholdValue/2) + (thresholdValue%2) + 1) * (filterHeight + padding) + 78.5)
        }
        return (CGFloat((self.dataSourceArray[indexPath.row].childFilterArray.count/2) + (self.dataSourceArray[indexPath.row].childFilterArray.count%2)) * (filterHeight + padding) + 78.5)
    }
}
