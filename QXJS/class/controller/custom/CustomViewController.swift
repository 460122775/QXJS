//
//  ProductListViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    @IBOutlet var customTable: UITableView!
    var customDataArr : NSMutableArray?
    var CustomTableViewCellIndentifier : String!
    var mainMenuView : MainMenuView!
    var _selectCustomConfigDic : NSMutableDictionary?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        CustomTableViewCellIndentifier = "CustomTableViewCell"
        mainMenuView = MainMenuView.sharedInstance()
        mainMenuView.removeFromSuperview()
        mainMenuContainer.addSubview(mainMenuView)
        
        // Testing data.c
        var stuffTempDic : NSMutableDictionary
        for var i = 0; i < 10; i++
        {
            stuffTempDic = NSMutableDictionary()
            stuffTempDic.setValue("戴亚晨\(i)", forKey: "name")
            stuffTempDic.setValue("2016-02-29 18:27", forKey: "time")
            stuffTempDic.setValue("男", forKey: "sex")
            stuffTempDic.setValue("19", forKey: "age")
            stuffTempDic.setValue("18181910426", forKey: "phone")
            stuffTempDic.setValue("四川成都市高新区会龙大道", forKey: "address")
            stuffTempDic.setValue("沙发、茶几套装", forKey: "detail")
            customDataArr?.addObject(stuffTempDic)
        }
        
        customTable.delegate = self
        customTable.dataSource = self
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
        return 40
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CustomTableViewCellIndentifier) as UITableViewCell!
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: CustomTableViewCellIndentifier) as UITableViewCell!
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor(red: 120 / 255, green: 128 / 255, blue: 138 / 255, alpha: 1)
            cell!.textLabel?.font = UIFont.systemFontOfSize(12)
            cell!.detailTextLabel?.textColor = UIColor.grayColor()
            cell!.contentView.backgroundColor = UIColor.clearColor();
            cell!.separatorInset = UIEdgeInsetsZero
            cell!.layoutMargins = UIEdgeInsetsZero
        }
        let customConfigDic : NSMutableDictionary = (customDataArr?.objectAtIndex(indexPath.row as Int) as? NSMutableDictionary)!
        if customConfigDic != _selectCustomConfigDic
        {
            cell!.contentView.backgroundColor = UIColor.clearColor();
            cell!.textLabel?.textColor = UIColor.whiteColor()
        }else{
            cell!.contentView.backgroundColor = UIColor(red: 4/255.0, green: 178/255.0, blue: 217/255.0, alpha: 1)
            cell!.textLabel?.textColor = UIColor.blackColor()
        }
        cell!.textLabel?.text = (customConfigDic.objectForKey("time") as! String) + "（" + (customConfigDic.objectForKey("name") as! String) + "）"
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var arry = tableView.visibleCells;
        for(var i = 0; i < arry.count; i++)
        {
            let _cell : UITableViewCell = arry[i] ;
            _cell.contentView.backgroundColor = UIColor.clearColor();
            _cell.textLabel?.textColor = UIColor.whiteColor()
        }
        _selectCustomConfigDic = (customDataArr?.objectAtIndex(indexPath.row as Int) as? NSMutableDictionary)!
        let cell : UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.contentView.backgroundColor = UIColor(red: 4/255.0, green: 178/255.0, blue: 217/255.0, alpha: 1)
        cell.textLabel?.textColor = UIColor.blackColor()
//        self.delegate?.getSelectedProduct(_selectProductConfigDic!)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
