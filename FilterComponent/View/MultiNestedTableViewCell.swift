//
//  MultiNestedTableViewCell.swift
//  FilterComponent
//
//  Created by Sumit Makkar on 09/06/20.
//  Copyright © 2020 Sumit Makkar. All rights reserved.
//

import UIKit

class MultiNestedTableViewCell: UITableViewCell
{
    @IBOutlet weak var multinestedTableview: UITableView!
    @IBOutlet weak var headLabel: UILabel!
    
    var filterModel: MyModel?
    var cellIndexPath: IndexPath?
    var reloadIndexPath: ((IndexPath?, MyModel?) -> Void)?
    var selectedSection: Int = 0
    
    func setupCell(withChildArray currentFilterModel: MyModel?, and cIndexPath: IndexPath)
    {
        headLabel.text                       = currentFilterModel?.filterName
        self.filterModel                     = currentFilterModel
        self.cellIndexPath                   = cIndexPath
        self.multinestedTableview.dataSource = self
        self.multinestedTableview.delegate   = self
    }
}

extension MultiNestedTableViewCell: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.filterModel?.childFilterArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if !(self.filterModel?.childFilterArray[section].isExpanded ?? true)
        {
            return 0
        }
        return self.filterModel?.childFilterArray[section].subchildArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let fModel = filterModel else { return UITableViewCell() }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InnerCell", for: indexPath) as? InnerMostTableViewCell
        {
            cell.setupCell(with: fModel.childFilterArray[indexPath.section].subchildArray?[indexPath.row].childFilterName)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.filterModel?.childFilterArray[section].childFilterName
    }
}

extension MultiNestedTableViewCell: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 24
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerButton = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        headerButton.setTitle(self.filterModel?.childFilterArray[section].childFilterName, for: UIControl.State.normal)
        headerButton.backgroundColor = .red
        headerButton.tag = section
        headerButton.addTarget(self, action: #selector(headerTapped(sender:)), for: UIControl.Event.touchUpInside)
        return headerButton
    }
    
    @objc private func headerTapped(sender: UIButton)
    {
        self.filterModel?.childFilterArray[self.selectedSection].isExpanded = false
        self.selectedSection                                                = sender.tag
        self.filterModel?.childFilterArray[self.selectedSection].isExpanded = true
//        self.multinestedTableview.reloadData()
        var rows = [IndexPath]()
        for i in 0...1
        {
            rows.append(IndexPath(row: i, section: 0))
        }
        for i in 0..<filterModel!.childFilterArray[1].subchildArray!.count
        {
            rows.append(IndexPath(row: i, section: 0))
        }
        self.multinestedTableview.reloadData()
        self.reloadIndexPath?(self.cellIndexPath, filterModel)
    }
}
