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
    let dateFormatter = NSDateFormatter()
    
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        dateFormatter.dateFormat = "yyyy - MM - dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        self.webView.layer.borderWidth = 1
        self.webView.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).CGColor
    }
    
    func showNewsData()
    {
        isNewsState = true
        // Judge if needs to download data.
        
        // Download data.
        let urlStr : NSString = "\(URL_Server)/news/downloadData"
        print("\(urlStr)")
        let url = NSURL(string: urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in

            if response == nil || data == nil
            {
                return
            }
            print(String(data: data!, encoding: NSUTF8StringEncoding)!)
            let resultDic : NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            let resultStr : String = resultDic.valueForKey("result") as! String
            if resultStr == FAIL
            {
                // Tell reason of FAIL.
                SwiftNotice.showText("网络不给力，获取数据失败")
                return
            }
            // Show result data.
            let dataArr = resultDic.valueForKey("list") as? NSMutableArray
            // Tell user the result.
            if dataArr == nil || dataArr?.count == 0
            {
                SwiftNotice.showText("无数据")
                return
            }
            if self.newsArr != nil && self.newsArr?.count > 0
            {
                self.newsArr?.removeAllObjects()
            }else if self.newsArr == nil{
                self.newsArr = NSMutableArray()
            }
            var newsDic : NSMutableDictionary? = nil
            for _newsDic in dataArr!
            {
                newsDic = NSMutableDictionary(dictionary: (_newsDic as! NSDictionary))
                newsDic?.removeObjectForKey("content")
                self.newsArr!.addObject(newsDic!)
            }
            if self.newsArr != nil
            {
                dispatch_async(dispatch_get_main_queue())
                {
                    self.tableView.reloadData()
                    self.showContentView(0)
                }
            }
        })
        task.resume()
    }
    
    func showActivityData()
    {
        isNewsState = false
        
        // Download data.
        let urlStr : NSString = "\(URL_Server)/activity/downloadData"
        print("\(urlStr)")
        let url = NSURL(string: urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            
            if response == nil || data == nil
            {
                return
            }
            print(String(data: data!, encoding: NSUTF8StringEncoding)!)
            let resultDic : NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
            let resultStr : String = resultDic.valueForKey("result") as! String
            if resultStr == FAIL
            {
                // Tell reason of FAIL.
                print("服务端下载activity失败，请重试!")
                SwiftNotice.showText("网络不给力，获取数据失败")
                return
            }
            // Show result data.
            let dataArr = resultDic.valueForKey("list") as? NSMutableArray
            // Tell user the result.
            if dataArr == nil || dataArr?.count == 0
            {
                print("No data.")
                SwiftNotice.showText("无数据")
                return
            }
            if self.activityArr != nil && self.activityArr?.count > 0
            {
                self.activityArr?.removeAllObjects()
            }else if self.activityArr == nil{
                self.activityArr = NSMutableArray()
            }
            var newsDic : NSMutableDictionary? = nil
            for _newsDic in dataArr!
            {
                newsDic = NSMutableDictionary(dictionary: (_newsDic as! NSDictionary))
                newsDic?.removeObjectForKey("content")
                self.activityArr!.addObject(newsDic!)
            }
            if self.activityArr != nil
            {
                dispatch_async(dispatch_get_main_queue())
                {
                    self.tableView.reloadData()
                    self.showContentView(0)
                }
            }
        })
        task.resume()
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
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(NEWSCELL)
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: NEWSCELL)
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            cell!.backgroundColor = UIColor.clearColor()
            cell!.contentView.backgroundColor = UIColor.clearColor();
        }
        
        if isNewsState
        {
            let dataDic = self.newsArr?.objectAtIndex(indexPath.row) as! NSMutableDictionary
            cell?.textLabel?.text = dataDic.objectForKey("title") as? String
            cell?.textLabel?.textColor = UIColor.darkGrayColor()
            cell?.detailTextLabel?.text = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970:(dataDic.objectForKey("time") as! NSNumber).doubleValue))
            cell?.detailTextLabel?.textColor = UIColor.lightGrayColor()
        }else{
            let dataDic = self.activityArr?.objectAtIndex(indexPath.row) as! NSMutableDictionary
            cell?.textLabel?.text = dataDic.objectForKey("title") as? String
            cell?.textLabel?.textColor = UIColor.darkGrayColor()
            cell?.detailTextLabel?.text = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970:(dataDic.objectForKey("time") as! NSNumber).doubleValue))
            cell?.detailTextLabel?.textColor = UIColor.lightGrayColor()
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.showContentView(indexPath.row)
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.lightGrayColor()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cellToDeSelect:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor.whiteColor()
    }
    
    func showContentView(index : Int)
    {
        if isNewsState && self.newsArr != nil && index < self.newsArr?.count
        {
            let dataDic = self.newsArr?.objectAtIndex(index) as! NSMutableDictionary
            let urlStr : String = "\(URL_Server)/websrc/temple/news/newsdetaile.html?newsId=\((String)((dataDic.objectForKey("newsId") as! NSNumber).longLongValue))"
            self.webView.loadRequest(NSURLRequest(URL: NSURL(string: urlStr)!))
        }else if isNewsState == false && self.activityArr != nil && index < self.activityArr?.count{
            let dataDic = self.activityArr?.objectAtIndex(index) as! NSMutableDictionary
            let urlStr : String = "\(URL_Server)/websrc/temple/news/activitydetaile.html?activityId=\((String)((dataDic.objectForKey("activityId") as! NSNumber).longLongValue))"
            self.webView.loadRequest(NSURLRequest(URL: NSURL(string: urlStr)!))
        }
    }
}
