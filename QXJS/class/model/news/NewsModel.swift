//
//  NewsModel.swift
//  QXJS
//
//  Created by Yachen Dai on 4/10/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit
import SQLite

class NewsModel: NSObject {
   
    class func getBigNewsData() -> NSMutableArray?
    {
        if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE) != nil
        {
            do{
                // Get color data from database.
                let newsArr : NSMutableArray = NSMutableArray()
                var newsDic : NSMutableDictionary? = nil
                let db = try Connection("\(PATH_DATABASE)\(DATABASE_NAME)")
                let newsTable = Table("news")
                // Fetch news data from db.
                for news in try db.prepare(newsTable.filter(
                    (Expression<Int64>("state") == 2)).limit(999))
                {
                    newsDic = NSMutableDictionary()
                    newsDic!.setValue(NSNumber(longLong: news[Expression<Int64>("newsId")]), forKey: "newsId")
                    newsDic!.setValue(NSNumber(longLong: news[Expression<Int64>("userId")]), forKey: "userId")
                    newsDic!.setValue(NSNumber(longLong: news[Expression<Int64>("time")]), forKey: "time")
                    newsDic!.setValue(news[Expression<String?>("title")], forKey: "title")
                    newsDic!.setValue(NSNumber(longLong: news[Expression<Int64>("state")]), forKey: "state")
                    newsDic!.setValue(news[Expression<String?>("imgs")], forKey: "imgs")
                    newsDic!.setValue(news[Expression<String?>("content")], forKey: "content")
                    newsArr.addObject(newsDic!)
                }
                print("Get small news infos from database : \(newsArr)")
                return newsArr
            }catch let error as NSError{
                print("ProductModel: Database Error. [err:\(error)]")
                return nil
            }
        }else{
            return nil
        }
    }

    class func getBigActivityData() -> NSMutableArray?
    {
        if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE) != nil
        {
            do{
                // Get color data from database.
                let activityArr : NSMutableArray = NSMutableArray()
                var activityDic : NSMutableDictionary? = nil
                let db = try Connection("\(PATH_DATABASE)\(DATABASE_NAME)")
                let activityTable = Table("activity")
                // Fetch activity data from db.
                for activity in try db.prepare(activityTable.filter(
                    (Expression<Int64>("state") == 2)).limit(999))
                {
                    activityDic = NSMutableDictionary()
                    activityDic!.setValue(NSNumber(longLong: activity[Expression<Int64>("activityId")]), forKey: "activityId")
                    activityDic!.setValue(NSNumber(longLong: activity[Expression<Int64>("userId")]), forKey: "userId")
                    activityDic!.setValue(NSNumber(longLong: activity[Expression<Int64>("time")]), forKey: "time")
                    activityDic!.setValue(activity[Expression<String?>("title")], forKey: "title")
                    activityDic!.setValue(NSNumber(longLong: activity[Expression<Int64>("state")]), forKey: "state")
                    activityDic!.setValue(activity[Expression<String?>("imgs")], forKey: "imgs")
                    activityDic!.setValue(activity[Expression<String?>("content")], forKey: "content")
                    activityArr.addObject(activityDic!)
                }
                print("Get small activity infos from database : \(activityArr)")
                return activityArr
            }catch let error as NSError{
                print("ProductModel: Database Error. [err:\(error)]")
                return nil
            }
        }else{
            return nil
        }
    }
    
    class func downloadActivityData(db : Connection)
    {
        // Download data.
        let urlStr : NSString = "\(URL_Server)/activity/downloadData"
        print("\(urlStr)")
        let url = NSURL(string: urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            do {
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
                    return
                }
                // Delete.
                let stmt = try db.prepare("delete from activity")
                try stmt.run()
                
                // Show result data.
                let dataArr = resultDic.valueForKey("list") as? NSMutableArray
                // Tell user the result.
                if dataArr == nil || dataArr?.count == 0
                {
                    print("No data.")
                    NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + ACTIVITY)
                    SettingModel.downloadData()
                    return
                }
                // Insert into database.
                let table = Table("activity")
                let activityId = Expression<Int64>("activityId")
                let content = Expression<String?>("content")
                let title = Expression<String?>("title")
                let imgs = Expression<String?>("imgs")
                let userId = Expression<Int64>("userId")
                let time = Expression<Int64>("time")
                let state = Expression<Int64>("state")
                for activityDic in dataArr!
                {
                    try db.run(table.insert(
                        activityId <- ((activityDic as! NSDictionary).objectForKey("activityId") as! NSNumber).longLongValue,
                        userId <- ((activityDic as! NSDictionary).objectForKey("userId") as! NSNumber).longLongValue,
                        title <- ((activityDic as! NSDictionary).objectForKey("title") as! String),
                        content <- ((activityDic as! NSDictionary).objectForKey("content") as! String),
                        imgs <- ((activityDic as! NSDictionary).objectForKey("imgs") as! String),
                        time <- ((activityDic as! NSDictionary).objectForKey("time") as! NSNumber).longLongValue,
                        state <- ((activityDic as! NSDictionary).objectForKey("state") as! NSNumber).longLongValue
                        ))
                }
                for group in try db.prepare(table.filter( Expression<Int64>("activityId") >= 1))
                {
                    print(group)
                }
                NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + ACTIVITY)
                SettingModel.downloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
                print("SettingModel: Database Error. [err:\(error)]")
            }
        })
        task.resume()
    }
    
    class func downloadNewsData(db : Connection)
    {
        
    }
}
