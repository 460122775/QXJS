//
//  DBModel.swift
//  YuYanIPad1
//
//  Created by Yachen Dai on 11/11/15.
//  Copyright © 2015 cdyw. All rights reserved.
//

import UIKit
import SQLite

class DBModel: NSObject
{
    class func initDB()
    {
        do{
            // Load config from UserDefaults.
            // If NOT nil, then load configs from local db.
//            NSUserDefaults.standardUserDefaults().removeObjectForKey(INITDATABASE)
            if NSUserDefaults.standardUserDefaults().objectForKey(INITDATABASE) != nil
            {
                print("Database init complete.")
                // Check update.
                
                // If find updates, then do update operate.
                
            }else{// If nil, then init db and data. 
                let backupDBPath : String? = NSBundle.mainBundle().pathForResource("qxjsDB", ofType: "sqlite3")
                if (backupDBPath == nil)
                {
                    // couldn't find backup db to copy, bail
                    print("couldn't find backup db to copy, bail")
                } else {
                    // Data base.
                    if NSFileManager.defaultManager().fileExistsAtPath("\(PATH_DATABASE)") == false
                    {
                        try NSFileManager.defaultManager().createDirectoryAtPath(PATH_DATABASE, withIntermediateDirectories: true, attributes: nil)
                    }
                    if NSFileManager.defaultManager().fileExistsAtPath("\(PATH_DATABASE)\(DATABASE_NAME)") == true
                    {
                        try NSFileManager.defaultManager().removeItemAtPath("\(PATH_DATABASE)\(DATABASE_NAME)")
                    }
                    try NSFileManager.defaultManager().copyItemAtPath(backupDBPath!, toPath: "\(PATH_DATABASE)\(DATABASE_NAME)")
                    // Modify Userdefaults.
                    NSUserDefaults.standardUserDefaults().setObject(INITDATABASE, forKey: INITDATABASE)
                }
            }
            print(PATH_DATABASE)
        }catch let error as NSError{
            print("Database Error. [err:\(error)]")
        }
    }
}
