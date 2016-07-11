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
    func updateCustomData()
}

class OrderView: UIView, UITableViewDelegate, UITableViewDataSource, CustomAddViewDelegate, OrderAddDelegate {
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var returnBackBtn: UIButton!
    @IBOutlet var orderTableView: UITableView!

    var orderViewDelegate : OrderViewDelegate?
    var orderAddView : OrderAddView?
    
    var _selectOrderDataDic : NSMutableDictionary?
    let TableCellIndentifier : String = "OrderTableViewCell"
    var orderDataArr : NSMutableArray?
    var customData : NSMutableDictionary?
    var customAddView : CustomAddView?
    
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
    
    @IBAction func updateCustomBtnClick(sender: AnyObject)
    {
        if customAddView == nil
        {
            self.customAddView = NSBundle.mainBundle().loadNibNamed("CustomAddView", owner: nil, options: nil)[0] as? CustomAddView
            self.customAddView!.delegate = self
        }
        self.addSubview(self.customAddView!)
        self.customAddView!.customData = self.customData
        self.customAddView?.initViewControl(false)
    }
    
    func customAddSuccess(_customData : NSMutableDictionary)
    {
        self.customData = _customData
        self.orderViewDelegate?.updateCustomData()
        self.nameLabel.text = (self.customData!.objectForKey("customName") as? String)! + "    " + (self.customData!.objectForKey("phone") as? String)!
    }
    
    func initViewByData(_orderDataArr : NSMutableArray?, _customData : NSMutableDictionary)
    {
//        self.orderDataArr = _orderDataArr
        self.customData = _customData
        self.nameLabel.text = (_customData.objectForKey("customName") as? String)! + "    " + (_customData.objectForKey("phone") as? String)!
        self.orderDataArr = CustomModel.getOrderData((self.customData!.objectForKey("customId") as! NSNumber).longLongValue, state: -1)
        // Must reload data in main queue, or maybe crashed.
        dispatch_async(dispatch_get_main_queue(), {
            self.orderTableView.reloadData()
        });
        self._selectOrderDataDic = nil
    }
    
    @IBAction func deleteCustomControl(sender: AnyObject)
    {
        // create the alert
        let alert = UIAlertController(title: "请确认", message: "确认要删除该客户信息吗？", preferredStyle: UIAlertControllerStyle.Alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { action in
            let result : Bool = CustomModel.deleteCustomData(self.customData)!
            if result == true
            {
                SwiftNotice.showText("删除成功")
                self.orderViewDelegate?.updateCustomData()
                self.returnBackBtnClick(self.returnBackBtn)
            }else{
                SwiftNotice.showText("删除失败")
            }
        }))
        
        // show the alert
        let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window!.rootViewController!.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteOrderBtnClick(sender: UIButton)
    {
        if self._selectOrderDataDic == nil
        {
            SwiftNotice.showText("请选择需要删除的订单")
        }else{
            // create the alert
            let alert = UIAlertController(title: "请确认", message: "确认要删除选中的订单吗？", preferredStyle: UIAlertControllerStyle.Alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { action in
                let result : Bool = CustomModel.deleteOrderData(NSMutableDictionary(dictionary: self._selectOrderDataDic!))!
                if result == true
                {
                    SwiftNotice.showText("删除成功")
                    self.updateOrderData()
                }else{
                    SwiftNotice.showText("删除失败")
                }
            }))
            // show the alert
            let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window!.rootViewController!.presentViewController(alert, animated: true, completion: nil)
        
        }
    }
    
    @IBAction func addOrderBtnClick(sender: UIButton)
    {
        if self.orderAddView == nil
        {
            self.orderAddView = NSBundle.mainBundle().loadNibNamed("OrderAddView", owner: nil, options: nil)[0] as? OrderAddView
            self.orderAddView!.orderAddDelegate = self
        }
        self.orderAddView?.customDataDic = self.customData
        self.addSubview(self.orderAddView!)
        self.orderAddView?.initViewControl()
    }
    
    // OrderAddDelegate
    func updateOrderData()
    {
        self.orderDataArr = CustomModel.getOrderData((self.customData?.objectForKey("customId") as! NSNumber).longLongValue, state: -1)
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
