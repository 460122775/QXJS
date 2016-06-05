//
//  DBInitTables.swift
//  YuYanIPad1
//
//  Created by Yachen Dai on 11/23/15.
//  Copyright © 2015 cdyw. All rights reserved.
//

import UIKit

class DBInitTables: NSObject {    
    class func initSystemInfoTable() -> String
    {
        let sqlStr_systemInfo : String = "CREATE TABLE 'system_info' (  'id' INTEGER NOT NULL PRIMARY KEY autoincrement,  'channel' text NOT NULL,  'content' text NOT NULL);"
        return sqlStr_systemInfo
    }
}
