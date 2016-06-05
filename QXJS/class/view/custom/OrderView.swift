//
//  ProductListMainView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

protocol OrderViewDelegate
{
    func orderMainViewReturnBack()
}

class OrderView: UIView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var sexLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    @IBOutlet var orderTableView: UITableView!

    var orderViewDelegate : OrderViewDelegate?
    
    var _selectOrderDataDic : NSMutableDictionary?
    let TableCellIndentifier : String = "OrderTableViewCell"
    var orderDataArr : NSMutableArray?
    var customData : NSMutableDictionary?
    
    override func drawRect(rect: CGRect)
    {
        self.orderTableView.delegate = self
        self.orderTableView.dataSource = self
        self.orderTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.orderTableView.registerNib(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: TableCellIndentifier)
    }
    
    @IBAction func returnBackBtnClick(sender: UIButton)
    {
        self._selectOrderDataDic = nil
        self.customData = nil
        if self.orderDataArr != nil && self.orderDataArr?.count > 0
        {
            self.orderDataArr?.removeAllObjects()
        }
        self.orderViewDelegate?.orderMainViewReturnBack()
    }
    
    func initViewByData(_orderDataArr : NSMutableArray?, _customData : NSMutableDictionary)
    {
        self.orderDataArr = _orderDataArr
        self.customData = _customData
        self.nameLabel.text = (_customData.objectForKey("customName") as? String)! + "    " + (_customData.objectForKey("phone") as? String)! + "    " +
            (_customData.objectForKey("address") as? String)!
//        self.sexLabel.text = _customData.objectForKey("sex") as? String
//        self.ageLabel.text =  String(format: "%i", (_customData.objectForKey("age") as! NSNumber).longLongValue)
        
        // Must reload data in main queue, or maybe crashed.
        dispatch_async(dispatch_get_main_queue(), {
            self.orderTableView.reloadData()
        });
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if orderDataArr != nil
        {
            return orderDataArr!.count
        }else{
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 45
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : OrderTableViewCell? = tableView.dequeueReusableCellWithIdentifier(TableCellIndentifier) as? OrderTableViewCell
        let customDataDic = (orderDataArr?.objectAtIndex(indexPath.row as Int) as? NSMutableDictionary)!
        cell?.setDataDic( customDataDic, index: indexPath.row, selected: (customDataDic == _selectOrderDataDic))
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var arry = tableView.visibleCells;
        for i in 0 ..< arry.count
        {
            let _cell : OrderTableViewCell = arry[i] as! OrderTableViewCell
            _cell.setBgStyle(i, selected: false)
        }
        _selectOrderDataDic = (orderDataArr?.objectAtIndex(indexPath.row as Int) as? NSMutableDictionary)!
        let cell : OrderTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! OrderTableViewCell
        cell.setBgStyle(indexPath.row, selected: true)
//        self.customDelegate?.showCustomDetail(_selectCustomDataDic!)
    }

}
