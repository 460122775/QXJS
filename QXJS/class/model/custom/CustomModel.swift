//
//  NewsModel.swift
//  QXJS
//
//  Created by Yachen Dai on 4/10/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit
import SQLite

class CustomModel: NSObject {
    class func getCustomData() -> NSMutableArray?
    {
        if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE) != nil
        {
            do{
                // Get color data from database.
                let customArr : NSMutableArray = NSMutableArray()
                
                var customDic : NSMutableDictionary? = nil
                let db = try Connection("\(PATH_DATABASE)\(DATABASE_NAME)")
                let customTable = Table("custom")
                // Fetch custom data from db.
                for custom in try db.prepare(customTable)
                {
                    customDic = NSMutableDictionary()
                    customDic!.setValue(NSNumber(longLong: custom[Expression<Int64>("customId")]), forKey: "customId")
                    customDic!.setValue(NSNumber(longLong: custom[Expression<Int64>("storeId")]), forKey: "storeId")
                    if NSNumber(longLong: custom[Expression<Int64>("sex")]) == 1
                    {
                        customDic!.setValue(String("男"), forKey: "sex")
                    }else{
                        customDic!.setValue(String("男"), forKey: "sex")
                    }
                    customDic!.setValue(NSNumber(longLong: custom[Expression<Int64>("age")]), forKey: "age")
                    customDic!.setValue(custom[Expression<String?>("customName")], forKey: "customName")
                    customDic!.setValue(custom[Expression<String?>("phone")], forKey: "phone")
                    customDic!.setValue(custom[Expression<String?>("address")], forKey: "address")
                    customArr.addObject(customDic!)
                }
                print("Get custom infos from database : \(customArr)")
                return customArr
            }catch let error as NSError{
                print("ProductModel: Database Error. [err:\(error)]")
                return nil
            }
        }else{
            return nil
        }
    }
    
    class func getOrderData(customId : Int64) -> NSMutableArray?
    {
        if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE) != nil
        {
            do{
                // Get color data from database.
                let orderArr : NSMutableArray = NSMutableArray()
                
                var orderDic : NSMutableDictionary? = nil
                let db = try Connection("\(PATH_DATABASE)\(DATABASE_NAME)")
                let orderTable = Table("t_order")
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd  h:mm"
                // Fetch order data from db.
                for order in try db.prepare(orderTable.filter(
                    Expression<Int64>("customId") == customId))
                {
                    orderDic = NSMutableDictionary()
                    orderDic!.setValue(NSNumber(longLong: order[Expression<Int64>("orderId")]), forKey: "orderId")
                    orderDic!.setValue(NSNumber(longLong: order[Expression<Int64>("customId")]), forKey: "customId")
                    orderDic!.setValue(
                        dateFormatter.stringFromDate(
                            NSDate(timeIntervalSince1970:
                                NSTimeInterval(order[Expression<Int64>("time")]))
                        ), forKey: "time")
                    orderDic!.setValue(order[Expression<String?>("address")], forKey: "address")
                    orderDic!.setValue(order[Expression<String?>("content")], forKey: "content")
                    orderDic!.setValue(order[Expression<String?>("comment")], forKey: "comment")
                    orderArr.addObject(orderDic!)
                }
                print("Get order infos from database : \(orderArr)")
                return orderArr
            }catch let error as NSError{
                print("ProductModel: Database Error. [err:\(error)]")
                return nil
            }
        }else{
            return nil
        }
    }
}
