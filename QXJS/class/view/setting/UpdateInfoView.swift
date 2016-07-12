//
//  UpdateInfoView.swift
//  QXJS
//
//  Created by Yachen Dai on 7/12/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class UpdateInfoView: UIView, UITextFieldDelegate {

    @IBOutlet var pwdTextField1: UITextField!
    
    @IBOutlet var pwdTextField2: UITextField!
    
    override func drawRect(rect: CGRect)
    {
        self.pwdTextField1.delegate = self
        self.pwdTextField2.delegate = self
    }

    @IBAction func returnBackBtnClick(sender: AnyObject)
    {
        self.removeFromSuperview()
    }
    
    @IBAction func saveBtnClick(sender: AnyObject)
    {
        if self.pwdTextField1.text == nil ||
            self.pwdTextField1.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 6 ||
            self.pwdTextField1.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 12
        {
            SwiftNotice.showText("密码长度错误")
            return
        }else if self.pwdTextField1.text != self.pwdTextField2.text{
            SwiftNotice.showText("两次密码不一致")
            return
        }
        
        // Download data.
        let urlStr : NSString = "\(URL_Server)/user/updateControl?userId=\(CurrentUserId)&username=" + CurrentUserName! + "&role=\(CurrentUserRole)&password="+self.pwdTextField1.text!+"&storeId=\(CurrentStoreId)"
        print("\(urlStr)")
        let url = NSURL(string: urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
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
                SwiftNotice.showText("修改密码失败，请重试!")
            }else{
                SwiftNotice.showText("密码修改成功！")
            }
        })
        task.resume()
    }
    
}
