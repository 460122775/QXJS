//
//  DBInitData.swift
//  YuYanIPad1
//
//  Created by Yachen Dai on 11/23/15.
//  Copyright © 2015 cdyw. All rights reserved.
//

import UIKit
import SQLite

class DBInitData: NSObject {
    
    class func initSystemInfoData() -> String
    {
        let sqlStr_systemInfo : String = "INSERT INTO 'system_info' VALUES ('1', 'dbversion', '1.0.0.0'); INSERT INTO 'system_info' VALUES ('2', 'systemTitle', 'LLX-09XD型天气雷达用户终端'); INSERT INTO 'system_info' VALUES ('4', 'radarPlace', '104.02,30.67'); INSERT INTO 'system_info' VALUES ('6', 'radarWaveForm', '3'); INSERT INTO 'system_info' VALUES ('7', 'setupVersion', '1.0,2581,2015/05/14 11:59:27'); INSERT INTO 'system_info' VALUES ('8', 'distanceLevel', '300,50,100,150,200,250,300'); INSERT INTO 'system_info' VALUES ('9', 'colorVersion', '1'); INSERT INTO 'system_info' VALUES ('10', 'productCfgVersion', '1'); INSERT INTO 'system_info' VALUES ('11', 'ipadDBVersion', '1');"
        return sqlStr_systemInfo
    }
}
