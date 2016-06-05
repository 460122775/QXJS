//
//  CacheManageModel.swift
//  YuYanIPad1
//
//  Created by Yachen Dai on 11/12/15.
//  Copyright © 2015 cdyw. All rights reserved.
//

import UIKit
import Alamofire

class CacheManageModel: NSObject
{
    var dateformatter : NSDateFormatter?
    let CACHEDPRODUCTNAME : String = "CachedProductName"
    
    class var getInstance : CacheManageModel
    {
        struct Static
        {
            static let instance : CacheManageModel = CacheManageModel()
        }
        return Static.instance
    }
    
    override init()
    {
//        print(">>>>>>>> path_product : \(PATH_PRODUCT)")
        do
        {
            try NSFileManager.defaultManager().createDirectoryAtPath(PATH_ProductImg, withIntermediateDirectories: true, attributes: nil)
        }catch let error as NSError{
            print("CacheManageModel: Create Directory ERROR[\(error)].")
        }
        dateformatter = NSDateFormatter()
        dateformatter?.dateFormat = "YYYYMMDDHHmmssSSSS"
    }
    
    func addCacheForProductImg(name : String, data _data : NSData)
    {
        // Save ProductData into file.
        if _data.length == 0
        {
            return
        }
        _data.writeToFile(PATH_ProductImg + name, atomically: false)
        // Show if file is exist.
//        let filemanager:NSFileManager = NSFileManager()
//        let files = filemanager.enumeratorAtPath(PATH_PRODUCT)
//        while let file = files?.nextObject() {
//            print(file)
//        }
        // Save Product data address into NSUserDefaults.
//        NSUserDefaults.standardUserDefaults().setValue(productName, forKey: CACHEDPRODUCTNAME + productName)
//        NSUserDefaults.standardUserDefaults().synchronize()
        // Remove cache data beyond max count.
        
    }
    
    func getCacheForProductImg(_productName : String) -> NSData?
    {
        // Get product data file which has already decompressed.
        return NSData(contentsOfFile:"\(PATH_ProductImg)\(_productName)")
    }
    
    func clearCacheForProductFile()
    {
        do
        {
            // If cached product file directory exists.
            if NSFileManager.defaultManager().fileExistsAtPath(PATH_ProductImg) == true
            {
                // Clear directory of caching product file.
                try NSFileManager.defaultManager().removeItemAtPath(PATH_ProductImg)
                try NSFileManager.defaultManager().createDirectoryAtPath(PATH_ProductImg, withIntermediateDirectories: true, attributes: nil)
            }
        }catch let error as NSError{
                print("CacheManageModel clear cache for product file ERROR [\(error)].")
        }
    }
    
    // Get size of cached product data file, and the unit is Byte.
    func getCacheSizeForProductImg() -> Int64
    {
        if NSFileManager.defaultManager().fileExistsAtPath(PATH_ProductImg)
        {
            let files = NSFileManager().enumeratorAtPath(PATH_ProductImg)
            while let file = files?.nextObject()
            {
                print("\(file)")
            }
            return NSFileManager.defaultManager().folderSizeAtPath(PATH_ProductImg)
        }
        return 0;
    }
    
    func addCacheForPicture()
    {
        
    }
    
    func addCacheForAudio()
    {
        
    }
    
    func deleteCacheProductFile()
    {
    
    }
    
    func deleteCacheForCache()
    {
        
    }
    
    func deleteCacheForAudio()
    {
        
    }
    
    func selectStorage() -> Int32
    {
        return 0
    }  
}

extension NSFileManager {
    func fileSizeAtPath(path: String) -> Int64 {
        do {
            let fileAttributes = try attributesOfItemAtPath(path)
            let fileSizeNumber = fileAttributes[NSFileSize]
            let fileSize = fileSizeNumber?.longLongValue
            return fileSize!
        } catch {
            print("error reading filesize, NSFileManager extension fileSizeAtPath")
            return 0
        }
    }
    
    func folderSizeAtPath(path: String) -> Int64 {
        var size : Int64 = 0
        do {
            let files = try subpathsOfDirectoryAtPath(path)
            for i in 0 ..< files.count {
                size += fileSizeAtPath(path + files[i])
            }
        } catch {
            print("error reading directory, NSFileManager extension folderSizeAtPath")
        }
        return size
    }
}
