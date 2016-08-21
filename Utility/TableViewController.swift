//
//  TableViewController.swift
//  Utility
//
//  Created by 藤田勝司 on 2016/08/21.
//  Copyright © 2016年 藤田勝司. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let data = ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "iii", "uuu"]
    
    class func view() -> TableViewController {
        return UIStoryboard(name: "TableViewController", bundle: nil).instantiateInitialViewController() as!TableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.registerNib(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.registerNib(UINib(nibName: "SpaceCell", bundle: nil), forCellReuseIdentifier: "SpaceCell")
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let text = data[notSpaceCellIndex(indexPath)]
        print(text)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addCountSpaceCell(data.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if isNotSpaceCell(indexPath) {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell
            cell.label.text = data[notSpaceCellIndex(indexPath)]
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("SpaceCell")
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if isNotSpaceCell(indexPath) {
            return UITableViewAutomaticDimension
        } else {
            return 10
        }
    }
    
    func addCountSpaceCell(count: Int) -> Int {
        return count*2 - 1
    }
    
    func isNotSpaceCell(indexPath: NSIndexPath) -> Bool {
        return indexPath.row % 2 == 0
    }
    
    func notSpaceCellIndex(indexPath: NSIndexPath) ->  Int {
        return indexPath.row / 2
    }
}
