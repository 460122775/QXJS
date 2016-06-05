//
//  StoreModel.swift
//  QXJS
//
//  Created by Yachen Dai on 4/14/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit
import SQLite

class StoreModel: NSObject {
    class func getStoreData() -> NSMutableArray?
    {
        if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE) != nil
        {
            do{
                // Get color data from database.
                let storeArr : NSMutableArray = NSMutableArray()
                var storeDic : NSMutableDictionary? = nil
                let db = try Connection("\(PATH_DATABASE)\(DATABASE_NAME)")
                let storeTable = Table("store")
                // Fetch news data from db.
                for store in try db.prepare(storeTable)
                {
                    storeDic = NSMutableDictionary()
                    storeDic!.setValue(NSNumber(longLong: store[Expression<Int64>("storeId")]), forKey: "storeId")
                    storeDic!.setValue(NSNumber(longLong: store[Expression<Int64>("provinceId")]), forKey: "provinceId")
                    storeDic!.setValue(store[Expression<String?>("storeName")], forKey: "storeName")
                    storeDic!.setValue(store[Expression<String?>("phone")], forKey: "phone")
                    storeDic!.setValue(store[Expression<String?>("address")], forKey: "address")
                    storeDic!.setValue(store[Expression<String?>("img")], forKey: "img")
                    storeArr.addObject(storeDic!)
                }
                print("Get small store infos from database : \(storeArr)")
                return storeArr
            }catch let error as NSError{
                print("ProductModel: Database Error. [err:\(error)]")
                return nil
            }
        }else{
            return nil
        }
    }
}
