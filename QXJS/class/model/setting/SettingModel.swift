//
//  SettingModel.swift
//  QXJS
//
//  Created by Yachen Dai on 4/7/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit
import SQLite
import Alamofire

struct SessionProperties {
    static let identifier : String! = "url_session_background_download"
}

var imgPathArr : [String] = []

class SettingModel: NSObject
{
    
    class func downloadDataControl() -> Bool
    {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE + ACTIVITY)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE + NEWS)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE + COLLOCATION)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE + CUSTOM)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE + ORDER)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE + PHOTO)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE + GROUP)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE + PRODUCT)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE + PARAM)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE + STORE)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE + USER)
        dispatch_async(dispatch_get_main_queue()) { 
            downloadData()
        }
        return true
    }
    
    class func downloadData() -> Bool
    {
        do{
            let db = try Connection("\(PATH_DATABASE)\(DATABASE_NAME)")
            if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE + ACTIVITY) == nil
            {
                dispatch_async(dispatch_get_main_queue()) {
                    SettingModel.downloadActivityData(db)
                }
            }else if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE + NEWS) == nil{
                dispatch_async(dispatch_get_main_queue()) {
                    SettingModel.downloadNewsData(db)
                }
            }else if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE + COLLOCATION) == nil{
                dispatch_async(dispatch_get_main_queue()) {
                    SettingModel.downloadCollocationData(db)
                }
            }else if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE + CUSTOM) == nil{
                dispatch_async(dispatch_get_main_queue()) {
                    SettingModel.downloadCustomData(db)
                }
            }else if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE + ORDER) == nil{
                dispatch_async(dispatch_get_main_queue()) {
                    SettingModel.downloadOrderData(db)
                }
            }else if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE + PHOTO) == nil{
                dispatch_async(dispatch_get_main_queue()) {
                    SettingModel.downloadPhotoData(db)
                }
            }else if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE + GROUP) == nil{
                dispatch_async(dispatch_get_main_queue()) {
                    SettingModel.downloadGroupData(db)
                }
            }else if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE + PRODUCT) == nil{
                dispatch_async(dispatch_get_main_queue()) {
                    SettingModel.downloadProductData(db)
                }
            }else if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE + PARAM) == nil{
                dispatch_async(dispatch_get_main_queue()) {
                    SettingModel.downloadParamData(db)
                }
            }else if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE + STORE) == nil{
                dispatch_async(dispatch_get_main_queue()) {
                    SettingModel.downloadStoreData(db)
                }
            }else if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE + USER) == nil{
                dispatch_async(dispatch_get_main_queue()) {
                    SettingModel.downloadUserData(db)
                }
            }
            else{
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
                    print("This is run on the background queue")
                    let _configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(SessionProperties.identifier)
                    let _backgroundSession = NSURLSession(configuration: _configuration, delegate: DownloadSessionDelegate.sharedInstance, delegateQueue: nil)
                    SettingModel.cacheFile(_configuration, backgroundSession: _backgroundSession)
                    //                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //                        print("This is run on the main queue, after the previous code in outer block")
                    //                    })
                })

            }
        }catch let error as NSError{
            print("ProductModel: Database Error. [err:\(error)]")
            return false
        }
        return true
    }
    
    class func cacheFile(configuration : NSURLSessionConfiguration, backgroundSession : NSURLSession)
    {
        if imgPathArr.count == 0
        {
            return
        }
        let pathArr = imgPathArr.removeAtIndex(0).componentsSeparatedByString("+")
        var url = "\(URL_Server)/source/" + pathArr[0]
        let fileName = "/" + pathArr[2]
        let cachePath = pathArr[1]
        url = url.stringByReplacingOccurrencesOfString("\\\\", withString: "/", options: .LiteralSearch, range: nil)
        url = url.stringByReplacingOccurrencesOfString("\\", withString: "/", options: .LiteralSearch, range: nil)
        
        // Download data.
        Alamofire.request(.GET, url.stringByAppendingString(fileName)).responseData { response in
            if let httpError = response.result.error
            {
                let statusCode = httpError.code
                SwiftNotice.showText("数据文件下载失败，请检查网络后重试！")
            } else { //no errors
                let statusCode = (response.response?.statusCode)!
                if statusCode == 404
                {
                    print(">>>404:" + (response.request?.URL?.absoluteString)!)
                }else{
                    // Cache data.
                    let data = response.result.value!
                    if data.length > 0
                    {
                        data.writeToFile(cachePath + fileName, atomically: false)
                        print(cachePath + fileName)
                    }
                }
            }
            
//            if response.result.value == nil || response.result.value?.length <= 48
//            {
//                // Tell reason to user.
//                SwiftNotice.showText("数据文件下载失败，请检查网络后重试！")
//                return
//            }else{
//                
//            }
            if imgPathArr.count > 0
            {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
                    print("This is run on the background queue")
                    let _configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(SessionProperties.identifier)
                    let _backgroundSession = NSURLSession(configuration: _configuration, delegate: DownloadSessionDelegate.sharedInstance, delegateQueue: nil)
                    SettingModel.cacheFile(_configuration, backgroundSession: _backgroundSession)
                })
                
            }else{
                let filemanager:NSFileManager = NSFileManager()
                let files = filemanager.enumeratorAtPath(cachePath)
                while let file = files?.nextObject() {
                    print(file)
                }
            }
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
        // Download data.
        let urlStr : NSString = "\(URL_Server)/news/downloadData"
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
                    print("服务端下载news失败，请重试!")
                    return
                }
                // Delete.
                let stmt = try db.prepare("delete from news")
                try stmt.run()
                // Show result data.
                let dataArr = resultDic.valueForKey("list") as? NSMutableArray
                // Tell user the result.
                if dataArr == nil || dataArr?.count == 0
                {
                    print("No data.")
                    NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + NEWS)
                    SettingModel.downloadData()
                    return
                }
                // Insert into database.
                let table = Table("news")
                let newsId = Expression<Int64>("newsId")
                let content = Expression<String?>("content")
                let title = Expression<String?>("title")
                let imgs = Expression<String?>("imgs")
                let userId = Expression<Int64>("userId")
                let time = Expression<Int64>("time")
                let state = Expression<Int64>("state")
                for newsDic in dataArr!
                {
                    try db.run(table.insert(
                        newsId <- ((newsDic as! NSDictionary).objectForKey("newsId") as! NSNumber).longLongValue,
                        userId <- ((newsDic as! NSDictionary).objectForKey("userId") as! NSNumber).longLongValue,
                        title <- ((newsDic as! NSDictionary).objectForKey("title") as! String),
                        content <- ((newsDic as! NSDictionary).objectForKey("content") as! String),
                        imgs <- ((newsDic as! NSDictionary).objectForKey("imgs") as! String),
                        time <- ((newsDic as! NSDictionary).objectForKey("time") as! NSNumber).longLongValue,
                        state <- ((newsDic as! NSDictionary).objectForKey("state") as! NSNumber).longLongValue
                        ))
                }
                for group in try db.prepare(table.filter( Expression<Int64>("newsId") >= 1))
                {
                    print(group)
                }
                NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + NEWS)
                SettingModel.downloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    class func downloadCollocationData(db : Connection)
    {
        // Download data.
        let urlStr : NSString = "\(URL_Server)/collocation/downloadData"
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
                    print("服务端下载collocation失败，请重试!")
                    return
                }
                // Delete.
                let stmt = try db.prepare("delete from collocation")
                try stmt.run()
                // Show result data.
                let dataArr = resultDic.valueForKey("list") as? NSMutableArray
                // Tell user the result.
                if dataArr == nil || dataArr?.count == 0
                {
                    print("No data.")
                    NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + COLLOCATION)
                    SettingModel.downloadData()
                    return
                }
                // Insert into database.
                let table = Table("collocation")
                let collocationId = Expression<Int64>("collocationId")
                let imgPath = Expression<String?>("imgPath")
                let type = Expression<Int64>("type")
                let xValue = Expression<Int64>("xValue")
                let yValue = Expression<Int64>("yValue")
                let width = Expression<Int64>("width")
                let height = Expression<Int64>("height")
                for collocationDic in dataArr!
                {
                    imgPathArr.insert("collocationImg+" + PATH_CollocationImg + "+" + ((collocationDic as! NSDictionary).objectForKey("imgPath") as! String), atIndex: 0)
                    try db.run(table.insert(
                        collocationId <- ((collocationDic as! NSDictionary).objectForKey("collocationId") as! NSNumber).longLongValue,
                        imgPath <- ((collocationDic as! NSDictionary).objectForKey("imgPath") as! String),
                        type <- ((collocationDic as! NSDictionary).objectForKey("type") as! NSNumber).longLongValue,
                        xValue <- ((collocationDic as! NSDictionary).objectForKey("xValue") as! NSNumber).longLongValue,
                        yValue <- ((collocationDic as! NSDictionary).objectForKey("yValue") as! NSNumber).longLongValue,
                        width <- ((collocationDic as! NSDictionary).objectForKey("width") as! NSNumber).longLongValue,
                        height <- ((collocationDic as! NSDictionary).objectForKey("height") as! NSNumber).longLongValue
                        ))
                }
                // Clear img folder.
                // If cached collocation file directory exists.
                if NSFileManager.defaultManager().fileExistsAtPath(PATH_CollocationImg) == true
                {
                    // Clear directory of caching product file.
                    try NSFileManager.defaultManager().removeItemAtPath(PATH_CollocationImg)
                }
                try NSFileManager.defaultManager().createDirectoryAtPath(PATH_CollocationImg, withIntermediateDirectories: true, attributes: nil)
                for group in try db.prepare(table.filter( Expression<Int64>("collocationId") >= 1))
                {
                    print(group)
                }
                NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + COLLOCATION)
                SettingModel.downloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    class func downloadCustomData(db : Connection)
    {
        // Download data.
        let urlStr : NSString = "\(URL_Server)/custom/downloadData"
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
                    print("服务端下载custom失败，请重试!")
                    return
                }
                // Delete.
                let stmt = try db.prepare("delete from custom")
                try stmt.run()
                // Show result data.
                let dataArr = resultDic.valueForKey("list") as? NSMutableArray
                // Tell user the result.
                if dataArr == nil || dataArr?.count == 0
                {
                    print("No data.")
                    NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + CUSTOM)
                    SettingModel.downloadData()
                    return
                }
                // Insert into database.
                let table = Table("custom")
                let customId = Expression<Int64>("customId")
                let customName = Expression<String?>("customName")
                let phone = Expression<String?>("phone")
                let address = Expression<String?>("address")
                let storeId = Expression<Int64>("storeId")
                let sex = Expression<Int64>("sex")
                let age = Expression<Int64>("age")
                for customDic in dataArr!
                {
                    try db.run(table.insert(
                        customName <- ((customDic as! NSDictionary).objectForKey("customName") as! String),
                        phone <- ((customDic as! NSDictionary).objectForKey("phone") as! String),
                        address <- ((customDic as! NSDictionary).objectForKey("address") as! String),
                        customId <- ((customDic as! NSDictionary).objectForKey("customId") as! NSNumber).longLongValue,
                        storeId <- ((customDic as! NSDictionary).objectForKey("storeId") as! NSNumber).longLongValue,
                        sex <- ((customDic as! NSDictionary).objectForKey("sex") as! NSNumber).longLongValue,
                        age <- ((customDic as! NSDictionary).objectForKey("age") as! NSNumber).longLongValue
                        ))
                }
                for group in try db.prepare(table.filter( Expression<Int64>("customId") >= 1))
                {
                    print(group)
                }
                NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + CUSTOM)
                SettingModel.downloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
                print("SettingModel: Database Error. [err:\(error)]")
            }
        })
        task.resume()
    }
    
    class func downloadOrderData(db : Connection)
    {
        // Download data.
        let urlStr : NSString = "\(URL_Server)/order/downloadData"
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
                    print("服务端下载Order失败，请重试!")
                    return
                }
                // Delete.
                let stmt = try db.prepare("delete from t_order")
                try stmt.run()
                // Show result data.
                let dataArr = resultDic.valueForKey("list") as? NSMutableArray
                // Tell user the result.
                if dataArr == nil || dataArr?.count == 0
                {
                    print("No data.")
                    NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + ORDER)
                    SettingModel.downloadData()
                    return
                }
                // Insert into database.
                let table = Table("t_order")
                let orderId = Expression<Int64>("orderId")
                let customId = Expression<Int64>("customId")
                let address = Expression<String?>("address")
                let content = Expression<String?>("content")
                let comment = Expression<String?>("comment")
                let time = Expression<Int64>("time")
                for orderDic in dataArr!
                {
                    try db.run(table.insert(
                        address <- ((orderDic as! NSDictionary).objectForKey("address") as! String),
                        content <- ((orderDic as! NSDictionary).objectForKey("content") as! String),
                        comment <- ((orderDic as! NSDictionary).objectForKey("comment") as! String),
                        orderId <- ((orderDic as! NSDictionary).objectForKey("orderId") as! NSNumber).longLongValue,
                        customId <- ((orderDic as! NSDictionary).objectForKey("customId") as! NSNumber).longLongValue,
                        time <- ((orderDic as! NSDictionary).objectForKey("time") as! NSNumber).longLongValue
                        ))
                }
                for group in try db.prepare(table.filter( Expression<Int64>("orderId") >= 1))
                {
                    print(group)
                }
                NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + ORDER)
                SettingModel.downloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
                print("SettingModel: Database Error. [err:\(error)]")
            }
        })
        task.resume()
    }
    
    class func downloadPhotoData(db : Connection)
    {
        // Download data.
        let urlStr : NSString = "\(URL_Server)/photo/downloadData"
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
                    print("服务端下载photo失败，请重试!")
                    return
                }
                // Delete.
                let stmt = try db.prepare("delete from photo")
                try stmt.run()
                // Show result data.
                let dataArr = resultDic.valueForKey("list") as? NSMutableArray
                // Tell user the result.
                if dataArr == nil || dataArr?.count == 0
                {
                    print("No data.")
                    NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + PHOTO)
                    SettingModel.downloadData()
                    return
                }
                // Insert into database.
                let table = Table("photo")
                let photoId = Expression<Int64>("photoId")
                let comment = Expression<String?>("comment")
                let productId = Expression<Int64>("productId")
                let userId = Expression<Int64>("userId")
                let type = Expression<Int64>("type")
                let enable = Expression<Int64>("enable")
                for photoDic in dataArr!
                {
                    try db.run(table.insert(
                        comment <- ((photoDic as! NSDictionary).objectForKey("comment") as! String),
                        photoId <- ((photoDic as! NSDictionary).objectForKey("photoId") as! NSNumber).longLongValue,
                        productId <- ((photoDic as! NSDictionary).objectForKey("productId") as! NSNumber).longLongValue,
                        userId <- ((photoDic as! NSDictionary).objectForKey("userId") as! NSNumber).longLongValue,
                        type <- ((photoDic as! NSDictionary).objectForKey("type") as! NSNumber).longLongValue,
                        enable <- ((photoDic as! NSDictionary).objectForKey("enable") as! NSNumber).longLongValue
                        ))
                }
                for group in try db.prepare(table.filter( Expression<Int64>("photoId") >= 1))
                {
                    print(group)
                }
                NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + PHOTO)
                SettingModel.downloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
                print("SettingModel: Database Error. [err:\(error)]")
            }
        })
        task.resume()
    }
    
    class func downloadGroupData(db : Connection)
    {
        // Download data.
        let urlStr : NSString = "\(URL_Server)/group/downloadData"
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
                    print("服务端下载Group失败，请重试!")
                    return
                }
                // Delete.
                let stmt = try db.prepare("delete from t_group")
                try stmt.run()
                // Show result data.
                let dataArr = resultDic.valueForKey("list") as? NSMutableArray
                // Tell user the result.
                if dataArr == nil || dataArr?.count == 0
                {
                    print("No data.")
                    NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + GROUP)
                    SettingModel.downloadData()
                    return
                }
                // Insert into database.
                let table = Table("t_group")
                let groupId = Expression<Int64>("groupId")
                let groupCd = Expression<String?>("groupCd")
                let seriesId = Expression<Int64>("seriesId")
                for groupDic in dataArr!
                {
                    try db.run(table.insert(
                        groupCd <- ((groupDic as! NSDictionary).objectForKey("groupCd") as! String),
                        groupId <- ((groupDic as! NSDictionary).objectForKey("groupId") as! NSNumber).longLongValue,
                        seriesId <- ((groupDic as! NSDictionary).objectForKey("seriesId") as! NSNumber).longLongValue
                        ))
                }
                for group in try db.prepare(table.filter( Expression<Int64>("groupId") >= 1))
                {
                    print(group)
                }
                NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + GROUP)
                SettingModel.downloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
                print("SettingModel: Database Error. [err:\(error)]")
            }
        })
        task.resume()
    }
    
    class func downloadProductData(db : Connection)
    {
        // Download data.
        let urlStr : NSString = "\(URL_Server)/product/downloadData"
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
                    print("服务端下载product失败，请重试!")
                    return
                }
                // Delete.
                let stmt = try db.prepare("delete from product")
                try stmt.run()
                // Show result data.
                let dataArr = resultDic.valueForKey("list") as? NSMutableArray
                // Tell user the result.
                if dataArr == nil || dataArr?.count == 0
                {
                    print("No data.")
                    NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + PRODUCT)
                    SettingModel.downloadData()
                    return
                }
                // Insert into database.
                let table = Table("product")
                let productId = Expression<Int64>("productId")
                let groupId = Expression<Int64>("groupId")
                let categoryId = Expression<Int64>("categoryId")
                let productName = Expression<String?>("productName")
                let productCd = Expression<String?>("productCd")
                let imgPath = Expression<String?>("imgPath")
                let paramJson = Expression<String?>("paramJson")
                let comment = Expression<String?>("comment")
                let enable = Expression<Int64>("enable")
                for productDic in dataArr!
                {
                    imgPathArr.insert("productImg+" + PATH_ProductImg + "+" + ((productDic as! NSDictionary).objectForKey("imgPath") as! String), atIndex: 0)
                    try db.run(table.insert(
                        productId <- ((productDic as! NSDictionary).objectForKey("productId") as! NSNumber).longLongValue,
                        groupId <- ((productDic as! NSDictionary).objectForKey("groupId") as! NSNumber).longLongValue,
                        categoryId <- ((productDic as! NSDictionary).objectForKey("categoryId") as! NSNumber).longLongValue,
                        productName <- ((productDic as! NSDictionary).objectForKey("productName") as! String),
                        productCd <- ((productDic as! NSDictionary).objectForKey("productCd") as! String),
                        imgPath <- ((productDic as! NSDictionary).objectForKey("imgPath") as! String),
                        comment <- ((productDic as! NSDictionary).objectForKey("comment") as? String),
                        paramJson <- ((productDic as! NSDictionary).objectForKey("paramJson") as? String),
                        enable <- ((productDic as! NSDictionary).objectForKey("enable") as! NSNumber).longLongValue
                        ))
                }
                // Clear img folder.
                // If cached collocation file directory exists.
                if NSFileManager.defaultManager().fileExistsAtPath(PATH_ProductImg) == true
                {
                    // Clear directory of caching product file.
                    try NSFileManager.defaultManager().removeItemAtPath(PATH_ProductImg)
                }
                try NSFileManager.defaultManager().createDirectoryAtPath(PATH_ProductImg, withIntermediateDirectories: true, attributes: nil)
                for group in try db.prepare(table.filter( Expression<Int64>("productId") >= 1))
                {
                    print(group)
                }
                NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + PRODUCT)
                SettingModel.downloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
                print("SettingModel: Database Error. [err:\(error)]")
            }
        })
        task.resume()
    }
    
    class func downloadParamData(db : Connection)
    {
        // Download data.
        let urlStr : NSString = "\(URL_Server)/param/downloadData"
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
                    print("服务端下载param失败，请重试!")
                    return
                }
                // Delete.
                let stmt = try db.prepare("delete from param")
                try stmt.run()
                // Show result data.
                let dataArr = resultDic.valueForKey("list") as? NSMutableArray
                // Tell user the result.
                if dataArr == nil || dataArr?.count == 0
                {
                    print("No data.")
                    NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + PARAM)
                    SettingModel.downloadData()
                    return
                }
                // Insert into database.
                let table = Table("param")
                let paramId = Expression<Int64>("paramId")
                let categoryId = Expression<Int64>("categoryId")
                let cname = Expression<String?>("cname")
                let ename = Expression<String?>("ename")
                let level = Expression<Int64>("level")
                for paramDic in dataArr!
                {
                    try db.run(table.insert(
                        paramId <- ((paramDic as! NSDictionary).objectForKey("paramId") as! NSNumber).longLongValue,
                        categoryId <- ((paramDic as! NSDictionary).objectForKey("categoryId") as! NSNumber).longLongValue,
                        cname <- ((paramDic as! NSDictionary).objectForKey("cname") as! String),
                        ename <- ((paramDic as! NSDictionary).objectForKey("ename") as! String),
                        level <- ((paramDic as! NSDictionary).objectForKey("level") as! NSNumber).longLongValue
                        ))
                }
                for group in try db.prepare(table.filter( Expression<Int64>("paramId") >= 1))
                {
                    print(group)
                }
                NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + PARAM)
                SettingModel.downloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
                print("SettingModel: Database Error. [err:\(error)]")
            }
        })
        task.resume()
    }

    class func downloadStoreData(db : Connection)
    {
        // Download data.
        let urlStr : NSString = "\(URL_Server)/store/downloadData"
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
                    print("服务端下载store失败，请重试!")
                    return
                }
                // Delete.
                let stmt = try db.prepare("delete from store")
                try stmt.run()
                // Show result data.
                let dataArr = resultDic.valueForKey("list") as? NSMutableArray
                // Tell user the result.
                if dataArr == nil || dataArr?.count == 0
                {
                    print("No data.")
                    NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + STORE)
                    SettingModel.downloadData()
                    return
                }
                // Insert into database.
                let table = Table("store")
                let storeId = Expression<Int64>("storeId")
                let provinceId = Expression<Int64>("provinceId")
                let storeName = Expression<String?>("storeName")
                let address = Expression<String?>("address")
                let phone = Expression<String?>("phone")
                let img = Expression<String?>("img")
                
                for storeDic in dataArr!
                {
                    try db.run(table.insert(
                        storeId <- ((storeDic as! NSDictionary).objectForKey("storeId") as! NSNumber).longLongValue,
                        provinceId <- ((storeDic as! NSDictionary).objectForKey("provinceId") as! NSNumber).longLongValue,
                        storeName <- ((storeDic as! NSDictionary).objectForKey("storeName") as! String),
                        address <- ((storeDic as! NSDictionary).objectForKey("address") as! String),
                        phone <- ((storeDic as! NSDictionary).objectForKey("phone") as! String),
                        img <- ((storeDic as! NSDictionary).objectForKey("img") as! String)
                        ))
                }
                for group in try db.prepare(table.filter( Expression<Int64>("storeId") >= 1))
                {
                    print(group)
                }
                NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + STORE)
                SettingModel.downloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
                print("SettingModel: Database Error. [err:\(error)]")
            }
        })
        task.resume()
    }
    
    class func downloadUserData(db : Connection)
    {
        // Download data.
        let urlStr : NSString = "\(URL_Server)/user/downloadData"
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
                    print("服务端下载user失败，请重试!")
                    return
                }
                // Delete.
                let stmt = try db.prepare("delete from user")
                try stmt.run()
                // Show result data.
                let dataArr = resultDic.valueForKey("list") as? NSMutableArray
                // Tell user the result.
                if dataArr == nil || dataArr?.count == 0
                {
                    print("No data.")
                    NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + USER)
                    SettingModel.downloadData()
                    return
                }
                // Insert into database.
                let table = Table("user")
                let userId = Expression<Int64>("userId")
                let storeId = Expression<Int64>("storeId")
                let username = Expression<String?>("username")
                let password = Expression<String?>("password")
                let role = Expression<Int64>("role")
                for userDic in dataArr!
                {
                    try db.run(table.insert(
                        userId <- ((userDic as! NSDictionary).objectForKey("userId") as! NSNumber).longLongValue,
                        storeId <- ((userDic as! NSDictionary).objectForKey("storeId") as! NSNumber).longLongValue,
                        username <- ((userDic as! NSDictionary).objectForKey("username") as! String),
                        password <- ((userDic as! NSDictionary).objectForKey("password") as! String),
                        role <- ((userDic as! NSDictionary).objectForKey("role") as! NSNumber).longLongValue
                        ))
                }
                for group in try db.prepare(table.filter( Expression<Int64>("userId") >= 1))
                {
                    print(group)
                }
                NSUserDefaults.standardUserDefaults().setObject(DOWNLOADDATA, forKey: INITDATABASE + USER)
                SettingModel.downloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
                print("SettingModel: Database Error. [err:\(error)]")
            }
        })
        task.resume()
    }

}
