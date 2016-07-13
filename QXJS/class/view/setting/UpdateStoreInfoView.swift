//
//  UpdateInfoView.swift
//  QXJS
//
//  Created by Yachen Dai on 7/12/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class UpdateStoreInfoView: UIView, UITextFieldDelegate {

    @IBOutlet var storeNameTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    
    override func drawRect(rect: CGRect)
    {
        
    }

    @IBAction func returnBackBtnClick(sender: AnyObject)
    {
        self.removeFromSuperview()
    }
    
    @IBAction func saveBtnClick(sender: AnyObject)
    {
        if self.storeNameTextField.text == nil ||
            self.storeNameTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 6 ||
            self.storeNameTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 50
        {
            SwiftNotice.showText("店铺名称长度（6～20）")
            return
        }else if self.phoneTextField.text == nil ||
            self.phoneTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 6 ||
            self.phoneTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 50
        {
            SwiftNotice.showText("电话号码长度（6～50）个字符")
            return
        }else if self.addressTextField.text == nil ||
        self.addressTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 6 ||
        self.addressTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 100
        {
            SwiftNotice.showText("店铺地址长度（6～100）个字符")
            return
        }
        
        // Download data.
        let urlStr : NSString = "\(URL_Server)/store/updateControl?storeId=\(CurrentStoreId)&storeName=" + self.storeNameTextField.text! + "&provinceId=0&address="+self.addressTextField.text!+"&phone="+self.phoneTextField.text!+"&img=null"
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
                SwiftNotice.showText("修改店铺信息失败，请重试!")
            }else{
                SwiftNotice.showText("店铺信息修改成功！")
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.removeFromSuperview()
                }
            }
        })
        task.resume()
    }
}
