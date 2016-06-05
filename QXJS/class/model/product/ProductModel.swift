//
//  ProductModel.swift
//  QXJS
//
//  Created by Yachen Dai on 3/29/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit
import SQLite

class ProductModel: NSObject
{
    class func getProductDataBySeries(seriesId : Int64, searchStr : String) -> NSMutableArray?
    {
        if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE) != nil
        {
            do{
                // Get color data from database.
                let groupArr : NSMutableArray = NSMutableArray()
                var groupDic : NSMutableDictionary? = nil
                let db = try Connection("\(PATH_DATABASE)\(DATABASE_NAME)")
                let groupTable = Table("t_group")
                let productTable = Table("product")
                // Fetch group data from db.
                for group in try db.prepare(groupTable.filter(
                    (Expression<Int64>("seriesId") == seriesId)
                    ).limit(999))
                {
                    groupDic = NSMutableDictionary()
                    groupDic!.setValue(NSNumber(longLong: group[Expression<Int64>("groupId")]), forKey: "groupId")
                    groupDic!.setValue(NSNumber(longLong: seriesId), forKey: "seriesId")
                    groupDic!.setValue(group[Expression<String?>("groupCd")], forKey: "groupCd")
                    groupArr.addObject(groupDic!)
                }
                for _groupDic in groupArr
                {
                    var flag = true
                    for product in try db.prepare(productTable.filter(
                        (Expression<Int64>("groupId") == (_groupDic.objectForKey("groupId") as! NSNumber).longLongValue)).filter( Expression<String?>("productCd").like("%" + searchStr + "%")).limit(1))
                    {
                        flag = false
                        _groupDic.setValue(NSNumber(longLong: product[Expression<Int64>("productId")]), forKey: "productId")
                        _groupDic.setValue(NSNumber(longLong: product[Expression<Int64>("categoryId")]), forKey: "categoryId")
                        _groupDic.setValue(product[Expression<String?>("productName")], forKey: "productName")
                        _groupDic.setValue(product[Expression<String?>("productCd")], forKey: "productCd")
                        _groupDic.setValue(product[Expression<String?>("imgPath")], forKey: "imgPath")
                        break
                    }
                    if flag
                    {
                        groupArr.removeObject(_groupDic)
                    }
                }
                print("Get group infos from database : \(groupArr)")
                return groupArr
            }catch let error as NSError{
                print("ProductModel: Database Error. [err:\(error)]")
                return nil
            }
        }else{
            return nil
        }
    }
    
    class func getProductDataByGroup(groupId : Int64) -> NSMutableArray?
    {
        if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE) != nil
        {
            do{
                // Get color data from database.
                let productArr : NSMutableArray = NSMutableArray()
                var productDic : NSMutableDictionary? = nil
                let db = try Connection("\(PATH_DATABASE)\(DATABASE_NAME)")
                let productTable = Table("product")
                // Fetch group data from db.
                for product in try db.prepare(productTable.filter(
                    (Expression<Int64>("groupId") == groupId)).limit(999))
                {
                    productDic = NSMutableDictionary()
                    productDic!.setValue(NSNumber(longLong: product[Expression<Int64>("productId")]), forKey: "productId")
                    productDic!.setValue(NSNumber(longLong: groupId), forKey: "groupId")
                    productDic!.setValue(NSNumber(longLong: product[Expression<Int64>("categoryId")]), forKey: "categoryId")
                    productDic!.setValue(product[Expression<String?>("productCd")], forKey: "productCd")
                    productDic!.setValue(product[Expression<String?>("productName")], forKey: "productName")
                    productDic!.setValue(product[Expression<String?>("comment")], forKey: "comment")
                    productDic!.setValue(product[Expression<String?>("paramJson")], forKey: "paramJson")
                    productDic!.setValue(product[Expression<String?>("imgPath")], forKey: "imgPath")
                    productArr.addObject(productDic!)
                }
                print("Get product infos from database : \(productArr)")
                return productArr
            }catch let error as NSError{
                print("ProductModel: Database Error. [err:\(error)]")
                return nil
            }
        }else{
            return nil
        }
    }
    
    class func getUserPhotoDataByProduct(productId : Int64) -> NSMutableArray?
    {
        if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE) != nil
        {
            do{
                // Get color data from database.
                let photoPathArr : NSMutableArray = NSMutableArray()
                let db = try Connection("\(PATH_DATABASE)\(DATABASE_NAME)")
                let photoTable = Table("photo")
                // Fetch group data from db.
                for photo in try db.prepare(photoTable.filter(
                    (Expression<Int64>("productId") == productId)).limit(999))
                {
                    photoPathArr.addObject(photo[Expression<String?>("path")]!)
                }
                print("Get product infos from database : \(photoPathArr)")
                return photoPathArr
            }catch let error as NSError{
                print("ProductModel: Database Error. [err:\(error)]")
                return nil
            }
        }else{
            return nil
        }
    }
    
    
}
