//
//  ProductListViewController.swift
//  QXJS
//
//  Created by Yachen Dai on 2/4/16.
//  Copyright © 2016 qxjs. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController
{

    @IBOutlet var mainMenuContainer : UIView!
    @IBOutlet var mainContainer : UIView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var userRoleLabel: UILabel!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var storeAddressLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    var mainMenuView : MainMenuView!
    var delegate = DownloadSessionDelegate.sharedInstance
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mainMenuView = MainMenuView.sharedInstance()
        mainMenuView.removeFromSuperview()
        mainMenuContainer.addSubview(mainMenuView)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.usernameLabel.text = "用 户 名：" + CurrentUserName!
        if CurrentUserRole == 4
        {
            self.userRoleLabel.text = "用户角色：超级管理员"
        }else if CurrentUserRole == 3{
            self.userRoleLabel.text = "用户角色：管理员"
        }else if CurrentUserRole == 2{
            self.userRoleLabel.text = "用户角色：店长"
        }else if CurrentUserRole == 1{
            self.userRoleLabel.text = "用户角色：店员"
        }
        self.storeNameLabel.text = CurrentStoreName
        self.storeAddressLabel.text = CurrentStoreAddress
        self.phoneLabel.text = CurrentStorePhone
    }
    
    var firstClick : Bool = true
    @IBAction func downloadDataBtnClick(sender: UIButton)
    {
        if firstClick
        {
            firstClick = false
            let progressView : ProgressView! = NSBundle.mainBundle().loadNibNamed("ProgressView", owner: nil, options: nil)[0] as? ProgressView
            self.view.window?.addSubview(progressView)
            SettingModel.UpdateDataControl()
            firstClick = true
        }
//        else{
//            let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(SessionProperties.identifier)
//            let backgroundSession = NSURLSession(configuration: configuration, delegate: self.delegate, delegateQueue: nil)
//            SettingModel.cacheFile(configuration, backgroundSession: backgroundSession)
//        }
    }

    @IBAction func logoutBtnClick(sender: UIButton)
    {
        CurrentUserId = 0
        NSUserDefaults.standardUserDefaults().removeObjectForKey("CurrentUserId")
        CurrentUserName = ""
        NSUserDefaults.standardUserDefaults().objectForKey("CurrentUserName")
        CurrentStoreId = 0
        NSUserDefaults.standardUserDefaults().objectForKey("CurrentStoreId")
        CurrentUserRole = 0
        NSUserDefaults.standardUserDefaults().objectForKey("CurrentUserRole")
        let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.presentViewController(loginViewController, animated: false, completion: nil)
        (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController = loginViewController
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
