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
    class func getSmallNewsData() -> NSMutableArray?
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
                    (Expression<Int64>("state") == 1)).limit(999))
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

    class func getSmallActivityData() -> NSMutableArray?
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
                    (Expression<Int64>("state") == 1)).limit(999))
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
}
