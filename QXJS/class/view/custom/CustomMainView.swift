//
//  ProductListMainView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class CustomMainView: UIView, UITableViewDelegate, UITableViewDataSource,
    UITextFieldDelegate, CustomAddViewDelegate{
    @IBOutlet var customTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!

    var customDelegate : CustomViewDelegate?
    
    var _selectCustomDataDic : NSMutableDictionary?
    let TableCellIndentifier : String = "CustomTableViewCell"
    var customDataArr : NSMutableArray?
    var customAddView : CustomAddView?
    
    
    override func drawRect(rect: CGRect)
    {
        self.customTableView.delegate = self
        self.customTableView.dataSource = self
        self.customTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.customTableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: TableCellIndentifier)
    }
    
    func initViewByData(_customDataArr : NSMutableArray)
    {
        self.customDataArr = _customDataArr
        // Must reload data in main queue, or maybe crashed.
        dispatch_async(dispatch_get_main_queue(), {
            self.customTableView.reloadData()
        });
    }
    
    @IBAction func onAddCustomBtnClick(sender: UIButton)
    {
        if customAddView == nil
        {
            self.customAddView = NSBundle.mainBundle().loadNibNamed("CustomAddView", owner: nil, options: nil)[0] as? CustomAddView
            self.customAddView!.delegate = self
        }
        self.addSubview(self.customAddView!)
        self.customAddView?.initViewControl(true)
    }
    
    func customAddSuccess(_customData : NSMutableDictionary)
    {
        // Update data.
        self.customDataArr = CustomModel.getCustomData(-1)
        self.initViewByData(self.customDataArr!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if customDataArr != nil
        {
            return customDataArr!.count
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
        let cell : CustomTableViewCell? = tableView.dequeueReusableCellWithIdentifier(TableCellIndentifier) as? CustomTableViewCell
        let customDataDic = (customDataArr?.objectAtIndex(indexPath.row as Int) as? NSMutableDictionary)!
        cell?.setDataDic( customDataDic, index: indexPath.row, selected: (customDataDic == _selectCustomDataDic))
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var arry = tableView.visibleCells;
        for i in 0 ..< arry.count
        {
            let _cell : CustomTableViewCell = arry[i] as! CustomTableViewCell
            _cell.setBgStyle(i, selected: false)
        }
        _selectCustomDataDic = (customDataArr?.objectAtIndex(indexPath.row as Int) as? NSMutableDictionary)!
        let cell : CustomTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        cell.setBgStyle(indexPath.row, selected: true)
        self.customDelegate?.showCustomDetail(_selectCustomDataDic!)
    }

}
