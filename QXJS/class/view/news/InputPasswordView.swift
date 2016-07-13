//
//  InputPasswordView.swift
//  QXJS
//
//  Created by yasin zhang on 16/7/13.
//  Copyright © 2016年 qxjs. All rights reserved.
//

import UIKit

class InputPasswordView: UIView {

    @IBOutlet var pwdTextField: UITextField!
    
    override func drawRect(rect: CGRect)
    {
        
    }
    
    @IBAction func goBackBtnClick(sender: AnyObject)
    {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.removeFromSuperview()
        }
    }
    
    @IBAction func saveBtnClick(sender: AnyObject)
    {
        if self.pwdTextField.text == nil ||
            self.pwdTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 6 ||
            self.pwdTextField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 12
        {
            SwiftNotice.showText("密码长度错误")
            return
        }else if self.pwdTextField.text != CurrentUserPwd{
            SwiftNotice.showText("密码错误")
            return
        }
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.removeFromSuperview()
        }
    }
    
}
