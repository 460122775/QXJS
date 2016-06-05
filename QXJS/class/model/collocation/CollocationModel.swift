//
//  CollocationModel.swift
//  QXJS
//
//  Created by Yachen Dai on 3/30/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit
import SQLite

class CollocationModel: NSObject {
    class func getCollocationData() -> NSMutableArray?
    {
        if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE) != nil
        {
            do{
                // Get color data from database.
                let livingRoomArr : NSMutableArray = NSMutableArray()
                let curtainArr : NSMutableArray = NSMutableArray()
                let sofaArr : NSMutableArray = NSMutableArray()
                let floorArr : NSMutableArray = NSMutableArray()
                let collocationArr : NSMutableArray = NSMutableArray()
                collocationArr.addObject(livingRoomArr)
                collocationArr.addObject(curtainArr)
                collocationArr.addObject(sofaArr)
                collocationArr.addObject(floorArr)
                
                var collocationDic : NSMutableDictionary? = nil
                let db = try Connection("\(PATH_DATABASE)\(DATABASE_NAME)")
                let collocationTable = Table("collocation")
                // Fetch collocation data from db.
                for collocation in try db.prepare(collocationTable)
                {
                    collocationDic = NSMutableDictionary()
                    collocationDic!.setValue(NSNumber(longLong: collocation[Expression<Int64>("type")]), forKey: "type")
                    collocationDic!.setValue(NSNumber(longLong: collocation[Expression<Int64>("xValue")]), forKey: "xValue")
                    collocationDic!.setValue(NSNumber(longLong: collocation[Expression<Int64>("yValue")]), forKey: "yValue")
                    collocationDic!.setValue(NSNumber(longLong: collocation[Expression<Int64>("width")]), forKey: "width")
                    collocationDic!.setValue(NSNumber(longLong: collocation[Expression<Int64>("height")]), forKey: "height")
                    collocationDic!.setValue(collocation[Expression<String?>("imgPath")], forKey: "imgPath")
                    if collocation[Expression<Int64>("type")] == 1
                    {
                        livingRoomArr.addObject(collocationDic!)
                    }else if collocation[Expression<Int64>("type")] == 2{
                        sofaArr.addObject(collocationDic!)
                    }else if collocation[Expression<Int64>("type")] == 3{
                        curtainArr.addObject(collocationDic!)
                    }else if collocation[Expression<Int64>("type")] == 4{
                        floorArr.addObject(collocationDic!)
                    }
                }
                print("Get collocation infos from database : \(collocationArr)")
                return collocationArr
            }catch let error as NSError{
                print("ProductModel: Database Error. [err:\(error)]")
                return nil
            }
        }else{
            return nil
        }
    }
}
