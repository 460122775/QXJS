//
//  ProductListMainView.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class NewsMainView: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var webView: UIWebView!
    @IBOutlet var tableView: UITableView!
    var newsArr : NSMutableArray?
    var activityArr : NSMutableArray?
    var isNewsState : Bool = true
    let NEWSCELL : String = "NEWSCELL"
    
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func showNewsData()
    {
        isNewsState = true
    }
    
    func showActivityData()
    {
        isNewsState = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isNewsState
        {
            if self.newsArr != nil
            {
                return (self.newsArr?.count)!
            }else{
                return 0
            }
        }else{
            if self.activityArr != nil
            {
                return (self.activityArr?.count)!
            }else{
                return 0
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 65
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(NEWSCELL)
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: NEWSCELL)
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            cell!.backgroundColor = UIColor.clearColor()
            cell!.contentView.backgroundColor = UIColor.clearColor();
        }
        if isNewsState
        {
            
        }
        return cell!
    }
}
