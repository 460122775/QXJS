//
//  LoginViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/3/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var bgScrollView: UIScrollView!

    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var nameInput: UITextField!
    @IBOutlet var pwdInput: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Init directory && database.
        DBModel.initDB()
        
        // Login Btn.
        self.loginBtn.layer.masksToBounds = true
        self.loginBtn.layer.cornerRadius = 3
        self.nameInput.delegate = self
        self.pwdInput.delegate = self
        
        // Init login info.
        if NSUserDefaults.standardUserDefaults().objectForKey("CurrentUserId") != nil &&
            NSUserDefaults.standardUserDefaults().objectForKey("CurrentUserName") != nil &&
            NSUserDefaults.standardUserDefaults().objectForKey("CurrentStoreId") != nil &&
            NSUserDefaults.standardUserDefaults().objectForKey("CurrentUserRole") != nil
        {
            CurrentUserId = (NSUserDefaults.standardUserDefaults().objectForKey("CurrentUserId") as! NSNumber).intValue
            CurrentUserName = NSUserDefaults.standardUserDefaults().objectForKey("CurrentUserName") as? String
            CurrentStoreId = (NSUserDefaults.standardUserDefaults().objectForKey("CurrentStoreId") as! NSNumber).intValue
            CurrentUserRole = (NSUserDefaults.standardUserDefaults().objectForKey("CurrentUserRole") as! NSNumber).intValue
            CurrentStoreName = NSUserDefaults.standardUserDefaults().objectForKey("CurrentStoreName") as? String
            CurrentStoreAddress = NSUserDefaults.standardUserDefaults().objectForKey("CurrentStoreAddress") as? String
            CurrentStorePhone = NSUserDefaults.standardUserDefaults().objectForKey("CurrentStorePhone") as? String
//            SettingModel.downloadDataControl(),
            MainMenuView.sharedInstance().companyBrandBtnClick(nil)
            self.view.makeToast(message: "登录成功，正在初始化数据，请耐心等待。。。", duration: 120, position: HRToastPositionCenter)
        }else{
            // Add Notification.
            // Keyboard stuff.
            let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
            center.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
            center.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
            center.addObserver(self, selector: #selector(LoginViewController.loginControl(_:)), name: LOGIN, object: nil)
        }
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: LOGIN, object: nil)
    }
    
    @IBAction func LoginBtnClick(sender: AnyObject)
    {
        // Login.
        if self.nameInput.text == nil || self.nameInput.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 || self.pwdInput.text == nil || self.pwdInput.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.view.makeToast(message: "用户名或者密码不能为空!", duration: 2.0, position: HRToastPositionTop, title: "错误")
            return
        }
        
        let urlStr : NSString =
            "\(URL_Server)/user/loginControl?username=".stringByAppendingString(self.nameInput.text!).stringByAppendingString("&password=").stringByAppendingString(self.pwdInput.text!)
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
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.makeToast(message: "服务器错误，请重试", duration: 2.0, position: HRToastPositionTop, title: "错误")
                })
                return
            }
            // Show result data.
            let dataDic = resultDic.valueForKey("list") as? NSDictionary
            if dataDic == nil
            {
                NSNotificationCenter.defaultCenter().postNotificationName(LOGIN, object: FAIL)
            }else{
                CurrentUserId = (dataDic?.valueForKey("userId") as! NSNumber).intValue
                CurrentUserName = dataDic?.valueForKey("username") as? String
                CurrentStoreId = (dataDic?.valueForKey("storeId") as! NSNumber).intValue
                CurrentUserRole = (dataDic?.valueForKey("role") as! NSNumber).intValue
                CurrentStoreName = dataDic?.valueForKey("storeName") as? String
                CurrentStoreAddress = dataDic?.valueForKey("address") as? String
                CurrentStorePhone = dataDic?.valueForKey("phone") as? String
                
                NSUserDefaults.standardUserDefaults().setObject(dataDic?.valueForKey("userId") as! NSNumber, forKey: "CurrentUserId")
                NSUserDefaults.standardUserDefaults().setObject(dataDic?.valueForKey("username") as! String, forKey: "CurrentUserName")
                NSUserDefaults.standardUserDefaults().setObject(dataDic?.valueForKey("storeId") as! NSNumber, forKey: "CurrentStoreId")
                NSUserDefaults.standardUserDefaults().setObject(dataDic?.valueForKey("role") as! NSNumber, forKey: "CurrentUserRole")
                NSUserDefaults.standardUserDefaults().setObject(dataDic?.valueForKey("storeName") as! String, forKey: "CurrentStoreName")
                NSUserDefaults.standardUserDefaults().setObject(dataDic?.valueForKey("address") as! String, forKey: "CurrentStoreAddress")
                NSUserDefaults.standardUserDefaults().setObject(dataDic?.valueForKey("phone") as! String, forKey: "CurrentStorePhone")
                NSNotificationCenter.defaultCenter().postNotificationName(LOGIN, object: SUCCESS)
            }
        })
        task.resume()
    }
    
    func loginControl(notification: NSNotification)
    {
        let resultString : String = notification.object as! String
        if resultString == SUCCESS
        {
            self.view.makeToast(message: "登录成功，正在初始化数据，请耐心等待。。。", duration: 120, position: HRToastPositionCenter)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.loginControl(_:)), name: DOWNLOADDATA, object: nil)
            SettingModel.downloadDataControl()
            dispatch_async(dispatch_get_main_queue(), { 
                MainMenuView.sharedInstance().companyBrandBtnClick(nil)
            })
        }else{
            dispatch_async(dispatch_get_main_queue(), {
                self.view.makeToast(message: "用户名或密码有误", duration: 2.0, position: HRToastPositionCenter)
            })
        }
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        let info:NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat
        self.bgScrollView.contentSize = CGSizeMake(self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height + keyboardSize.height)
        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.bgScrollView.contentOffset = CGPointMake(0, self.nameInput.frame.origin.y - 50)
        }, completion: nil)
        
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        self.bgScrollView.contentSize = CGSizeMake(self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height)
        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.bgScrollView.contentOffset = CGPointMake(0, 0)
        }, completion: nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
