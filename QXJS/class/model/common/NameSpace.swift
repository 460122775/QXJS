//
//  NameSpace.h
//  YuYanIPad1
//
//  Created by Yachen Dai on 1/12/16.
//  Copyright © 2016 cdyw. All rights reserved.
//

import Foundation

var IP_Server : String = "114.55.138.179" //192.168.199.6
var PORT_SERVER : Int = 80 // 8080
var URL_Server : String = "http://\(IP_Server):\(PORT_SERVER)/QXJS"

var DATABASE_NAME : String = "qxjsDB.sqlite3"
var PATH_ProductImg : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! + "/productImg/"
var PATH_DATABASE : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! + "/db/"
var PATH_UserPhotoImg : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! + "/userPhotoImg/"
var PATH_CollocationImg : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! + "/collocationImg/"

var MAX_PRODUCTCACHE : Int = 30

var CurrentUserId : Int32 = 0
var CurrentUserName : String?
var CurrentStoreId : Int32 = 0
var CurrentUserRole : Int32 = 0
var CurrentStoreName : String?
var CurrentStoreAddress : String?
var CurrentStorePhone : String?

var ZeroValue : UInt32 = 0
var BYTE_ZERO : UInt8 = 0

let REMOTEUPDATE : String = "RemoteUpdate"
let INITDATABASE : String = "InitDatabase"
let DOWNLOADDATA : String = "DownLoadData"
let DOWNLOADSOURCE : String = "DownLoadSource"
let UPDATEPROCESS : String = "UpdateProcess"

let HTTP : String = "Http"
let LOGIN : String = "Login"
let CURRENTUSERINFO : String = "CurrentUserInfo"
let SUCCESS : String = "Success"
let FAIL : String = "Fail"
let APP_ACTIVE : String = "app_active"
let APP_STOP : String = "app_stop"

let INSERT : String = "Insert"
let DELETE : String = "Delete"
let UPDATE : String = "Update"
let SELECT : String = "Select"
let RECEIVE : String = "Receive"

let ACTIVITY : String = "Activity"
let NEWS : String = "News"
let COLLOCATION : String = "Collocation"
let CUSTOM : String = "Custom"
let ORDER : String = "Order"
let PHOTO : String = "Photo"
let GROUP : String = "Group"
let PRODUCT : String = "Product"
let PARAM : String = "Param"
let STORE : String = "Store"
let USER : String = "User"


